module Api
  module V1
    class AccountsController < ApiController
      def show
        @account = Account.find(params[:id])
        authorize @account

        render json: @account, serializer: AccountsSerializer
      end

      def index
        @accounts = User.find(params[:user_id])
        @accounts.each do |a|
          authorize a, :show?
        end

        render json: @accounts, each_serializer: AccountsSerializer
      end

      def update
        @account = Account.find(params[:id])
        authorize @account

        if @account.update_attributes(account_params)
          render json: @account, serializer: AccountsSerializer
        else
          render_error_response(@account.errors.full_messages.first, :unprocessable_entity)
        end
      end

      private

      def account_params
        params.require(:account).permit(:balance)
      end
    end
  end
end