module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        role = params.delete(:role)
        super
        @resource.add_role(role)
      end
    end
  end
end