module Api
  module V1
    class ApiController < ApplicationController
      before_action :set_default_locale
      include Rails::Pagination

      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from ActiveRecord::RecordNotFound,
                  with: :render_404
      rescue_from Pundit::NotAuthorizedError,
                  with: :render_404
      rescue_from ActionController::UnpermittedParameters,
                  ActionController::ParameterMissing,
                  ActiveRecord::RecordInvalid,
                  with: :render_422
      rescue_from ActionController::RoutingError,
                  with: :render_500

      before_action :authenticate_user!
      skip_before_action :authenticate_user!, only: [:index, :show]

      def render_error_response(messages, error_code = nil)
        error_messages = (messages.class == Array)? messages : [messages]
        resp = { errors: error_messages }
        render json: resp, status: error_code || 500
      end

      def render_success_response(data)
        render json: {
          status: :success,
          data: data
        }
      end

      private

      def set_default_locale
        I18n.default_locale = request.headers['X-Language'] || :vi
      end

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
