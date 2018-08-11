class UsdVndExchangeRateService
  class << self
    def endpoint
      "https://www.tygia.com/customize/exchange.json?from=usd_do_la_my&to=vnd_viet_nam_dong&value=1&r=1"
    end

    def get_rate
      HttpService.call(:get, endpoint)['items'].select{|x| x['bankcode'] == 'VIETCOM'}.first['to_num'].gsub(',','').to_i
    end
  end
end