module CdAdmin
  class CoursesController < AdminController
    before_action :set_cd_admin_course, only: [:show, :edit, :update, :destroy]

    # GET /cd_admin/courses
    # GET /cd_admin/courses.json
    def index
      @cd_admin_courses = ::Course.unscoped.where(is_public: true).order(:verification_status).page(params[:page] || 1)
    end

    # GET /cd_admin/courses/1
    # GET /cd_admin/courses/1.json
    def show
    end

    # GET /cd_admin/courses/1/edit
    def edit
    end

    # PATCH/PUT /cd_admin/courses/1
    # PATCH/PUT /cd_admin/courses/1.json
    def update
      respond_to do |format|
        if @cd_admin_course.update(cd_admin_course_params)
          format.html {redirect_to @cd_admin_course, notice: 'Course was successfully updated.'}
          format.json {render :show, status: :ok, location: @cd_admin_course}
        else
          format.html {render :edit}
          format.json {render json: @cd_admin_course.errors, status: :unprocessable_entity}
        end
      end
    end

    # DELETE /cd_admin/courses/1
    # DELETE /cd_admin/courses/1.json
    def destroy
      @cd_admin_course.destroy
      respond_to do |format|
        format.html {redirect_to cd_admin_courses_url, notice: 'Course was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_cd_admin_course
      @cd_admin_course = ::Course.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cd_admin_course_params
      params.require(:course).permit(:title, :description, :start_date, :is_public, :verification_status, :is_active, :period, :number_of_students, :tuition_fee, :cover_image, :category_id, :course_level_id, :location, :city_id, :district_id, :views, :status, :rating_count, :rating_points)
    end
  end
end
