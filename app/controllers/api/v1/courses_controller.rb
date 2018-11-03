module Api
  module V1
    class NotEnoughBalance < Exception; end
    class CourseOwnerEnroll < Exception; end

    class CoursesController < ApiController
      skip_before_action :authenticate_user!, only: [:index, :search, :view, :get_rating, :related_courses]

      wrap_parameters include: [:title, :description, :start_date, :is_free, :status,
                                :number_of_students, :period, :tuition_fee, :category_id, :is_public,
                                :course_level_id, :currency, :week_day_schedules_attributes, :cover_image
      ]

      skip_before_action :authenticate_user!, only: [:follow, :show, :index]
      before_action :check_course_owner, only: [:show, :update]

      def index
        @courses = Course.includes(:user, :category, :course_level, :week_day_schedules)
        if params[:sort_by] == 'popularity'
          @courses = @courses.order(views: :desc)
        elsif params[:sort_by] == 'time_desc'
          @courses = @courses.order(created_at: :desc)
        elsif params[:sort_by] == 'time_asc'
          @courses = @courses.order(created_at: :asc)
        else
          @courses = @courses.all
        end

        @courses.each do |course|
          authorize course
        end

        @courses = paginate @courses.includes(:user, :category, :course_level, :week_day_schedules)
        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def upcomming_classes
        current_wday = Time.current.strftime("%A").downcase
        current_minute = Time.current.min + Time.current.hour * 60

        @courses = Course.where(status: :started).joins(:participations)\
                    .where(participations: {user_id: current_user.id})\
                    .joins(:week_day_schedules).where(week_day_schedules: {day: current_wday})\
                    .joins(:lessons).where(lessons: {status: Lesson.NOT_STARTED})
                    .where("DATE_PART('hour', start_time) * 60 + DATE_PART('minute', start_time) < ?", current_minute)\
                    .where("DATE_PART('hour', end_time) * 60 + DATE_PART('minute', end_time) > ?", current_minute)
        @courses = @courses.includes(:user, :category, :course_level, :week_day_schedules, :lessons)

        @courses.each do |course|
          authorize course, :index?
        end

        render json: @courses, each_serializer: CoursesSerializer, full_info: true, bbb: true
      end

      def upcomming_teaching_classes
        current_wday = Time.current.strftime("%A").downcase
        current_minute = Time.current.min + Time.current.hour * 60

        @courses = Course.where(status: :started)\
                    .where(user_id: current_user.id)\
                    .joins(:week_day_schedules).where(week_day_schedules: {day: current_wday})\
                    .where("DATE_PART('hour', start_time) * 60 + DATE_PART('minute', start_time) < ?", current_minute)\
                    .where("DATE_PART('hour', end_time) * 60 + DATE_PART('minute', end_time) > ?", current_minute)
        @courses = @courses.includes(:user, :category, :course_level, :week_day_schedules, :lessons)

        @courses.each do |course|
          authorize course, :show?
        end

        render json: @courses, each_serializer: CoursesSerializer, full_info: true, bbb: true
      end

      def related_courses
        @course = Course.find(params[:course_id])
        @courses = Course.includes(:user, :category, :course_level, :week_day_schedules)
                     .where(category_id: @course.category_id).order(created_at: :desc)
        @courses = paginate @courses

        @courses.each do |course|
          authorize course, :index?
        end

        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def search
        specializes = params[:specializes] || []
        categories = params[:categories] || []
        orderBy = params[:order_by]

        if specializes.blank?
          sub_categories = Category.where(category_id: categories).map(&:id)
          categories += sub_categories
        else
          categories += specializes
        end

        solr_search = Course.search do
          fulltext params[:q]

          if !categories.blank?
            with(:category_id, categories)
          end

          if !params[:min_fee].blank?
            with(:tuition_fee).greater_than(params[:min_fee].to_i)
          end

          if !params[:max_fee].blank?
            with(:tuition_fee).less_than(params[:max_fee].to_i)
          end

        end

        if params[:week_day].blank?
          @courses = paginate Course.where(id: solr_search.results.map(&:id))
                                  .includes(:user, :category, :course_level, :week_day_schedules)
        else
          @courses = paginate Course.joins(:week_day_schedules)
                                  .where(id: solr_search.results.map(&:id), week_day_schedules: {day: params[:week_day]})
                                  .includes(:user, :category, :course_level, :week_day_schedules)
        end

        if orderBy == 'popularity'
          @courses = @courses.order(views: :desc)
        elsif orderBy == 'time_desc'
          # TODO should use publish_at here
          @courses = @courses.order(created_at: :desc)
        elsif orderBy == 'time_asc'
          # TODO should use publish_at here
          @courses = @courses.order(created_at: :asc)
        elsif orderBy == 'price_desc'
          @courses = @courses.order(tuition_fee: :desc)
        elsif orderBy == 'price_asc'
          @courses = @courses.order(tuition_fee: :asc)
        end

        @courses.each do |course|
          authorize course, :index?
        end

        render json: @courses, each_serializer: CoursesSerializer, full_info: true
      end

      def view
        @course = Course.find(params[:id])
        CourseView.new(@course).update_course_view(params[:token])
        render json: @course, serializer: CoursesSerializer
      end

      def create
        authorize Course
        @course = Course.unscoped.new(course_params)
        @course.user_id = current_user.id

        if @course.save
          render json: @course, serializer: CoursesSerializer
        else
          p @course.errors.full_messages.join(', ')
          render_error_response(@course.errors, :unprocessable_entity)
        end
      end

      def show
        token = CourseView.new(@course).new_view
        authorize @course
        render json: @course, serializer: CoursesSerializer, view_token: token, full_info: true, bbb: true
      end

      def update
        authorize @course
        if course_params[:week_day_schedules_attributes]
          schedule_to_delete = @course.week_day_schedules.pluck(:id)
        end

        if @course.update_attributes(course_params)
          WeekDaySchedule.where(id: schedule_to_delete).destroy_all
          render json: @course.reload, serializer: CoursesSerializer, full_info: true
        else
          @course.reload.week_day_schedules.where.not(id: schedule_to_delete).destroy_all
          render_error_response(@course.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @course = Course.find(params[:id])
        authorize @course
        @course.destroy
        render json: {id: @course.id}
      end

      def follow
        subscription = CourseSubscriber.create(user_id: current_user.id, course_id: params[:id])

        render json: subscription, each_serializer: CourseSubscriberSerializer
      end

      def enroll
        @course = Course.find(params[:id])
        authorize @course, :show?

        account = current_user.account
        error = nil

        begin
          account.with_lock do
            raise NotEnoughBalance if account.balance < @course.tuition_fee

            @participation = Participation.create(
              user_id: current_user.id,
              course_id: @course.id
            )

            raise CourseOwnerEnroll unless @participation.errors.messages.blank?

            payment = Payment.create(
              from_user_id: current_user.id,
              to_user_id: @course.user_id,
              amount: @course.tuition_fee,
              service_fee: (@course.tuition_fee * AppSettings.service_fee.to_f/100).ceil,
              service_fee_rate: AppSettings.service_fee.to_f/100,
              course_id: @course.id
            )

            account.update_attributes(balance: account.balance - @course.tuition_fee)

            raise NotEnoughBalance unless payment.errors.messages.blank? && account.errors.messages.blank?
          end
        rescue NotEnoughBalance => e
          error = 'not enough balance'
        rescue CourseOwnerEnroll => e
          error = @participation.errors.messages.first[1][0]
        end

        render_error_response(error, 402) and return if error
        render json: @participation, serializer: ParticipationsSerializer
      end

      def participants
        @course = Course.find(params[:id])
        authorize @course, :update?

        user_ids = Participation.where(course_id: @course.id).pluck(:user_id)
        @users = User.where(id: user_ids)
        render json: @users, each_serializer: UsersSerializer
      end

      def user_enrolled
        @course = Course.find(params[:id])
        enrolled = Participation.where(user_id: current_user.id, course_id: @course.id).exists?
        render_success_response(enrolled: enrolled)
      end

      def get_rating
        course = Course.find(params[:id])
        authorize course, :show?
        if course.course_ratings.count == 0
          render json: {rating: 0} and return
        end

        course.course_ratings.sum(:points).to_f/course.course_ratings.count
        render json: {rating: 1}
      end

      private

      def check_course_owner
        @course = Course.unscoped.find(params[:id])
        if (!current_user || @course.user_id != current_user.id) && !@course.is_public
          render_error_response('not found', 404)
        end
      end

      def course_params
        params.require(:course).permit(:title, :description, :start_date, :is_free, :status,
                                       :number_of_students, :period, :tuition_fee, :category_id, :is_public,
                                       :course_level_id, :cover_image, week_day_schedules_attributes: [:day, :start_time, :end_time]
        )
      end
    end
  end
end
