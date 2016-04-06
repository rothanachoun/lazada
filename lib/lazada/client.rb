require 'httparty'
require 'active_support/core_ext/hash'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Lazada
  class Client
    include HTTParty

    base_uri 'sellercenter-api.lazada.com.my'

    def initialize(api_key)
      @api_key = '3cbada57d0d3d41d5823b892efd53b60e8425b27'
    end

    def request_url(action, options = {})
      current_time_zone = 'Kuala Lumpur'
      timestamp = Time.now.in_time_zone(current_time_zone).iso8601

      parameters = {
        'Action': action,
        'Filter': 'all',
        'Format': 'JSON',
        'Timestamp': timestamp,
        'UserID': 'sotra@yoolk.com',
        'Version': '1.0'
      }
      parameters = parameters.merge(options) if options.present?

      parameters = Hash[parameters.sort{ |a, b| a[0] <=> b[0] }]
      params     = parameters.to_query

      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @api_key, params)
      url = "/?#{params}&Signature=#{signature}"
    end

    def get_products
      url = request_url('GetProducts')
      response = self.class.get(url)

      response['SuccessResponse']['Body']['Products']['Product'] if response['SuccessResponse'].present?
    end

    def post_product(params)
      url = request_url('ProductCreate')

      response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

      response
    end

    def update_product(params)
      url = request_url('ProductUpdate')

      params = { 'Product': params }
      response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

      response
    end

    def remove_product(seller_sku)
      url = request_url('ProductRemove')

      params = { 'Product': { 'SellerSku': seller_sku } }
      response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

      response
    end

    def feed_status(id)
      url = request_url('FeedStatus', { 'FeedID': id })
      response = self.class.get(url)

      response
    end

  end
end
