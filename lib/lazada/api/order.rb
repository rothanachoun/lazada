module Lazada
  module API
    module Order
      def get_orders(options = {})
        url = request_url('GetOrders')
        params = {}
        params['Status'] = options[:status] if !options[:status].nil?
        params['CreatedAfter'] = options[:created_after] if options[:created_after]

        url = request_url('GetOrders', params) if !params.nil?
        response = self.class.get(url).to_json
        if ENV['RAILS_ENV'].nil?
          response = JSON.parse(JSON[response], symbolize_names: true)
        else
          response = JSON.parse(response, symbolize_names: true)
        end
 
        # response[:SuccessResponse][:Body][:Orders] = [] # no [:Order] 
        return response[:SuccessResponse][:Body][:Orders] if response.dig(:SuccessResponse, :Body, :Orders).empty?
        return response[:SuccessResponse][:Body][:Orders][:Order] if response.dig(:SuccessResponse, :Body, :Orders, :Order)
        response
      end

      def get_order(id)
        url = request_url('GetOrder', { 'OrderId' => id })
        response = self.class.get(url).to_json
        if ENV['RAILS_ENV'].nil?
          response = JSON.parse(JSON[response], symbolize_names: true)
        else
          response = JSON.parse(response, symbolize_names: true)
        end

        return response[:SuccessResponse][:Body][:Orders] if response.dig(:SuccessResponse, :Body, :Orders)
        response
      end

      def get_order_items(id)
        url = request_url('GetOrderItems', { 'OrderId' => id })
        response = self.class.get(url).to_json
        if ENV['RAILS_ENV'].nil?
          response = JSON.parse(JSON[response], symbolize_names: true)
        else
          response = JSON.parse(response, symbolize_names: true)
        end

        return response[:SuccessResponse][:Body][:OrderItems] if response.dig(:SuccessResponse, :Body, :Orders)
        response
      end
    end
  end
end
