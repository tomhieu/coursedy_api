module Api
  module V1
    class CommentsController < ApiController
      skip_before_action :authenticate_user!, only: [:index]

      def index
        render json: Comment.where(course_id: params[:course_id]).includes(:user), each_serializer: CommentsSerializer
      end

      def create
        @comment = Comment.new(comment_params)
        @comment.user_id  = current_user.id
        @comment.course_id  = params[:course_id]

        if @comment.save
          render json: @comment, serializer: CommentsSerializer
        else
          render_error_response(@comment.errors, :unprocessable_entity)
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
