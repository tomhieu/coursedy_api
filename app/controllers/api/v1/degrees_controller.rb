module Api
  module V1
    class DegreesController < ApiController
      def create
        @degree = Degree.new(degree_params)
        @degree.user_id = current_user.id
        @degree.tutor_id = current_user.tutor.id
        if @degree.save
          render json: @degree, serializer: DegreesSerializer
        else
          render_error_response(@degree.errors)
        end
      end

      def index
        @degrees = Degree.where(user_id: current_user.id)
        render json: @degrees, each_serializer: DegreesSerializer
      end

      def destroy
        @degree = Degree.find(params[:id]).destroy
        render json: @degree, serializer: DegreesSerializer
      end

      private

      def degree_params
        params.require(:degree).permit(:item, :name)
      end
    end
  end
end