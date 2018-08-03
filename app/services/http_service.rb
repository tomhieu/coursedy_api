require 'net/http'

class HttpService
  class << self
    def call(method, url, parameters={})
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      case (method)
        when :post
          request = Net::HTTP::Post.new(uri)
          request.body = parameters.to_json
        when :get
          request = Net::HTTP::Get.new(uri)
        when :delete
          request = Net::HTTP::Delete.new(uri.request_uri)
        when :put
          request = Net::HTTP::Put.new(uri.request_uri)
      end

      request.add_field('Content-Type', 'application/json')

      response = http.request(request)

      JSON.parse(response.body)
    end
  end
end