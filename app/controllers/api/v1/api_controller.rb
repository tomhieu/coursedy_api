module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from ActiveRecord::RecordNotFound,
                  with: :render_404
      rescue_from ActionController::UnpermittedParameters,
                  ActionController::ParameterMissing,
                  ActiveRecord::RecordInvalid,
                  with: :render_422
      rescue_from ActionController::RoutingError,
                  with: :render_500

      before_action :authenticate_user!

      def render_error_response(messages, error_code = nil)
        error_messages = (messages.class == Array)? messages : [messages]
        resp = { errors: error_messages }
        render json: resp, status: error_code
      end

      def render_success_response(data)
        render json: {
          status: :success,
          data: data
        }
      end

      private

      def render_404(exception)
        render_error_response(exception.message, 404)
      end

      def render_422(exception)
        render_error_response(exception.message, 422)
      end

      def render_500(exception)
        render_error_response(exception.message, 500)
      end
    end
  end
end
