module Lazada
  module API
    module Product
      def get_products(status = 'all')
        url = request_url('GetProducts', { 'filter' => status })
        response = self.class.get(url).to_json
        response = JSON.parse(response, symbolize_names: true)

        return 'nil' if response.dig(:SuccessResponse, :Body, :Products).nil?
        return response[:SuccessResponse][:Body][:Products] if response.dig(:SuccessResponse, :Body, :Products).empty?
        return response[:SuccessResponse][:Body][:Products][:Product] if response.dig(:SuccessResponse, :Body, :Products, :Product)
        response
      end

      def create_product(params)
        url = request_url('CreateProduct')

        params = { 'Product' => product_params(params) }

        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true, dasherize: false))

        Lazada::API::Response.new(response)
      end

      def update_product(params)
        url = request_url('UpdateProduct')

        params = { 'Product' => product_params(params) }

        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true, dasherize: false))

        Lazada::API::Response.new(response)
      end

      def remove_product(seller_sku)
        url = request_url('RemoveProduct')

        params = {
          'Product' => {
            'Skus' => {
              'Sku' => {
                'SellerSku' => seller_sku
              }
            }
          }
        }

        response = self.class.post(url, body: params.to_xml(root: 'Request', skip_types: true))

        Lazada::API::Response.new(response)
      end

      def get_qc_status
        url = request_url('GetQcStatus')

        response = self.class.get(url)

        response['SuccessResponse']['Body']['Status'] if !response['SuccessResponse'].nil?
      end

      private

      def product_params(object)
        params = {}
        params['PrimaryCategory'] = object[:primary_category]
        params['SPUId'] = ''
        params['AssociatedSku'] = ''
        params['Attributes'] = {
          'name' => object[:name],
          'name_ms' => object[:name_ms] || object[:name],
          'short_description' => object[:short_description],
          'brand' => object[:brand] || 'Unbranded',
          'warranty_type' => object[:warranty_type] || 'No Warranty',
          'model' => object[:model]
        }

        params['Skus'] = {}
        params['Skus']['Sku'] = {
          'SellerSku' => object[:seller_sku],
          'size' => object[:variation],
          'quantity' => object[:quantity],
          'price' => object[:price],
          'package_length' => object[:package_length],
          'package_height' => object[:package_height],
          'package_weight' => object[:package_weight],
          'package_width' => object[:package_width],
          'package_content' => object[:package_content],
          'tax_class' => object[:tax_class] || 'default',
          'status' => object[:status]
        }

        params['Skus']['Sku']['color_family'] = object[:color_family] if !object[:color_family].nil?
        params['Skus']['Sku']['size'] = object[:size] if !object[:size].nil?
        params['Skus']['Sku']['flavor'] = object[:flavor] if !object[:flavor].nil?
        params['Skus']['Sku']['bedding_size_2'] = object[:bedding_size] if !object[:bedding_size].nil?

        params['Skus']['Sku']['Images'] = {}
        params['Skus']['Sku']['Images'].compare_by_identity

        if !object[:images].nil?
          object[:images].each do |image|
            url = migrate_image(image)

            params['Skus']['Sku']['Images']['Image'.dup] = url
          end
        end

        # maximum image: 8
        (8 - object[:images].size).times.each do |a|
          params['Skus']['Sku']['Images']['Image'.dup] = ''
        end

        params
      end
    end
  end
end
