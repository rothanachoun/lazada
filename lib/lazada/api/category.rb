module Lazada
  module API
    module Category
      def get_categories
        url = request_url('GetCategoryTree')
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['Categories']['Category'] if response['SuccessResponse']
        response
      end

      def get_category_attributes(primary_cateogory_id)
        url = request_url('GetCategoryAttributes', 'PrimaryCategory' => primary_cateogory_id)
        response = self.class.get(url)

        return response['SuccessResponse']['Body']['Attribute'] if response['SuccessResponse']
        response
      end
    end
  end
end
