require 'json'
module Lazada
  module API
    module Category
      def get_categories
        url = request_url('GetCategoryTree')
        response = self.class.get(url).to_json
        if ENV['RAILS_ENV'].nil?
          response = JSON.parse(JSON[response], symbolize_names: true)
        else
          response = JSON.parse(response, symbolize_names: true)
        end

        return response[:SuccessResponse][:Body] if response.dig(:SuccessResponse, :Body)
        response
      end

      def get_category_attributes(primary_cateogory_id)
        url = request_url('GetCategoryAttributes', 'PrimaryCategory' => primary_cateogory_id)
        response = self.class.get(url).to_json
        if ENV['RAILS_ENV'].nil?
          response = JSON.parse(JSON[response], symbolize_names: true)
        else
          response = JSON.parse(response, symbolize_names: true)
        end

        return response[:SuccessResponse][:Body] if response.dig(:SuccessResponse, :Body)
        response
      end
    end
  end
end
