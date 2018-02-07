module Lazada
  module API
    class Response
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def request_id
        response['SuccessResponse']['Head']['RequestId']
      end

      def success?
        !response['SuccessResponse'].nil?
      end

      def error?
        !response['ErrorResponse'].nil?
      end

      def warning?
        !response['SuccessResponse']['Body']['Warnings'].nil?
      end

      def warning_messages
        hash = {}
        response['SuccessResponse']['Body']['Warnings'].each do |warning|
          hash[warning['Field'].dup] = warning['Message']
        end

        hash
      end

      def error_messages
        return if response['ErrorResponse']['Body'].nil?

        hash = {}
        response['ErrorResponse']['Body']['Errors'].each do |error|
          hash[error['Field'].dup] = error['Message']
        end

        hash
      end
    end
  end
end
