require 'httparty'
require 'active_support/core_ext/hash'

require 'lazada/api/product'
require 'lazada/api/category'
require 'lazada/api/feed'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Lazada
  class Client
    include HTTParty
    include Lazada::API::Product
    include Lazada::API::Category
    include Lazada::API::Feed

    base_uri 'sellercenter-api.lazada.com.my'

    def initialize(api_key)
      @api_key = '3cbada57d0d3d41d5823b892efd53b60e8425b27'
    end

    protected

    def request_url(action, options = {})
      current_time_zone = 'Kuala Lumpur'
      timestamp = Time.now.in_time_zone(current_time_zone).iso8601

      parameters = {
        'Action' => action,
        'Filter' => 'all',
        'Format' => 'JSON',
        'Timestamp' => timestamp,
        'UserID' => 'sotra@yoolk.com',
        'Version' => '1.0'
      }
      parameters = parameters.merge(options) if options.present?

      parameters = Hash[parameters.sort{ |a, b| a[0] <=> b[0] }]
      params     = parameters.to_query

      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @api_key, params)
      url = "/?#{params}&Signature=#{signature}"
    end

  end
end
