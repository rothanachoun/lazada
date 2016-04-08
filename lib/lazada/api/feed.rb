module Lazada
  module API
    module Feed
      def feed_status(id)
        url = request_url('FeedStatus', { 'FeedID' => id })
        response = self.class.get(url)

        response
      end
    end
  end
end
