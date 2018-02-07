require 'httparty'
require 'addressable/uri'

require 'lazada/api/product'
require 'lazada/api/category'
require 'lazada/api/image'
require 'lazada/api/order'

module Lazada
  class Client
    include HTTParty
    include Lazada::API::Product
    include Lazada::API::Category
    include Lazada::API::Image
    include Lazada::API::Order

    base_uri 'sellercenter-api.lazada.com.my'

    def initialize(api_key, user_id)
      @api_key = api_key
      @user_id = user_id
    end

    protected

    def request_url(action, options = {})
      timestamp = Time.now.iso8601

      parameters = {
        'Action' => action,
        'Filter' => options.delete('filter'),
        'Format' => 'JSON',
        'Timestamp' => timestamp,
        'UserID' => @user_id,
        'Version' => '1.0'
      }

      parameters['Filter'] = '' if parameters['Filter'].nil?

      parameters = parameters.merge(options) if !options.empty?
      parameters = Hash[parameters.sort{ |a, b| a[0] <=> b[0] }]

      uri = Addressable::URI.new
      uri.query_values = parameters

      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @api_key, uri.query)
      url = "/?#{uri.query}&Signature=#{signature}"
    end

  end
end
