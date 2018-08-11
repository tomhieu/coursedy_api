module Api
  module V1
    class ExchangeRatesController < ApiController
      skip_before_action :authenticate_user!

      def index
        render json: [{from: 'usd', to: 'vnd', rate: UsdVndExchangeRateService.get_rate}]
      end
    end
  end
end