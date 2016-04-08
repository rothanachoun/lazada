module Lazada
  module API
    module Category
      def get_categories
        url = request_url('GetCategoryTree')
        response = self.class.get(url)

        response['SuccessResponse']['Body']['Categories']['Category']
      end

      def get_category_attributes(primary_cateogory_id)
        url = request_url('GetCategoryAttributes', 'PrimaryCategory' => primary_cateogory_id)
        response = self.class.get(url)

        response['SuccessResponse']['Body']['Attribute']
      end
    end
  end
end
