module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        super
      end
    end
  end
end