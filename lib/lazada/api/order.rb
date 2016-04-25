module Lazada
  module API
    module Order
      def get_orders(status = nil)
        url = request_url('GetOrders')
        url = request_url('GetOrders', 'Status' => status) if status.present?
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['Orders']['Order'] if response['SuccessResponse'].present?
        response
      end

      def get_order(id)
        url = request_url('GetOrder', { 'OrderId' => id })
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['Orders']['Order'] if response['SuccessResponse'].present?
        response
      end

      def get_order_items(id)
        url = request_url('GetOrderItems', { 'OrderId' => id })
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['OrderItems']['OrderItem'] if response['SuccessResponse'].present?
        response
      end
    end
  end
end
