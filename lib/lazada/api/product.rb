module Lazada
  module API
    module Product
      def get_products(status = 'all')
        url = request_url('GetProducts', { 'filter' => status })
        response = self.class.get(url)

        response['SuccessResponse']['Body']['Products']['Product'] if response['SuccessResponse'].present?
      end

      def create_product(params)
        url = request_url('ProductCreate')

        params = { 'Product' => params }
        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response
      end

      def update_product(params)
        url = request_url('ProductUpdate')

        params = { 'Product' => params }
        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response
      end

      def remove_product(seller_sku)
        url = request_url('ProductRemove')

        params = { 'Product' => { 'SellerSku' => seller_sku } }
        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        response
      end
    end
  end
end
