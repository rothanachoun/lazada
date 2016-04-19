module Lazada
  module API
    module Feed
      def feed_status(id)
        url = request_url('FeedStatus', { 'FeedID' => id })
        response = self.class.get(url)

        response
      end

      def feed_list
        url = request_url('FeedList')
        response = self.class.get(url)

        response
      end
    end
  end
end
