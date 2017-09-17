module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        # TODO define roles for users
        role = params.delete(:role)
        super
        @resource.add_role(role)
      end
    end
  end
end