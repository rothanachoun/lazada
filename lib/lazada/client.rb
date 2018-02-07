require 'httparty'
require 'addressable/uri'

require 'lazada/api/product'
require 'lazada/api/category'
require 'lazada/api/image'
require 'lazada/api/order'
require 'lazada/api/response'

module Lazada
  class Client
    include HTTParty
    include Lazada::API::Product
    include Lazada::API::Category
    include Lazada::API::Image
    include Lazada::API::Order

    def initialize(api_key, user_id, country)
      @api_key = api_key
      @user_id = user_id
      @country = country
    end

    def select_country(country)
      case country
      when 'my' # malaysia
        self.class.base_uri 'api.sellercenter.lazada.com.my'
      when 'sg' # singapore
        self.class.base_uri 'api.sellercenter.lazada.com.sg'
      when 'th' # thailand
        self.class.base_uri 'api.sellercenter.lazada.co.th'
      when 'id' # indonesia
        self.class.base_uri 'api.sellercenter.lazada.co.id'
      when 'vn' # vietnam
        self.class.base_uri 'api.sellercenter.lazada.vn'
      when 'ph' # phillipines
        self.class.base_uri 'api.sellercenter.lazada.com.ph'
      else
        raise RuntimeError, 'Lazada does not support your country at this moment.'
      end
    end

    protected

    def request_url(action, options = {})
      select_country(@country)

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
