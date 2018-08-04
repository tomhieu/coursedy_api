class GoogleService
  class << self
    def client_id
      AppSettings.google.client_id
    end

    def client_secret
      AppSettings.google.client_secret
    end

    def endpoint
      AppSettings.google.endpoint
    end

    def verify_user_token(token)
      HttpService.call(:get, "#{endpoint}/oauth2/v3/tokeninfo?id_token=#{token}")
    end
  end
end