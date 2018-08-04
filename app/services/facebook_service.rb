class FacebookService
  class << self
    def app_id
      AppSettings.facebook.app_id
    end

    def secret
      AppSettings.facebook.secret
    end

    def endpoint
      AppSettings.facebook.endpoint
    end

    def access_token
      HttpService.call(:get, "#{endpoint}/oauth/access_token?client_id=#{app_id}&client_secret=#{secret}&grant_type=client_credentials")['access_token']
    end

    def verify_user_token(token, app_user_id)
      HttpService.call(:get, "#{endpoint}/v3.1/#{app_user_id}?access_token=#{token}&fields=email,id,name")
    end
  end
end