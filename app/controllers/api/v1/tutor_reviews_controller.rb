module Api
  module V1
    class TutorReviewsController < ApiController
      def create
        @tutor_review = TutorReview.new(tutor_review_params)
        @tutor_review.teacher_id = params[:tutor_id]
        @tutor_review.save

        if @tutor_review.errors.messages.count > 0
          render_error_response(@tutor_review.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @tutor_review, serializer: TutorReviewsSerializer
        end
      end

      def show
        @tutor_review = TutorReview.find(params[:id])
        render json: @tutor_review, serializer: TutorReviewsSerializer
      end

      def index
        @tutor_reviews = TutorReview.where(teacher_id: params[:tutor_id]).includes(:user).order(created_at: :desc)
        @tutor_reviews = paginate @tutor_reviews
        render json: @tutor_reviews, each_serializer: TutorReviewsSerializer
      end

      def update
        @tutor_review = TutorReview.find(params[:id])

        if @tutor_review.update_attributes(content: tutor_review_params[:content])
          render json: @tutor_review, serializer: TutorReviewsSerializer
        else
          render_error_response(@tutor_review.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @tutor_review = TutorReview.find(params[:id])
        @tutor_review.destroy
        render json: {id: @tutor_review.id}
      end

      private

      def tutor_review_params
        params.require(:tutor_review).permit(:content, :user_id)
      end
    end
  end
end