module NearApi
  class Fetch
    class << self
      BASE_URL = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{ENV["API_SECRET_KEY"]}".freeze

      def data
        response = connection.get

        case response.status
        when 200
          JSON.parse(response.body)
        else
          Rails.logger.error("Near API error: #{response.status} - #{response.body}")
          nil
        end

      rescue Faraday::TimeoutError
        Rails.logger.error("Near API timeout")
        nil
      rescue Faraday::ConnectionFailed
        Rails.logger.error("Near API connection failed")
        nil
      rescue StandardError => e
        Rails.logger.error("Near API error: #{e.message}")
        nil
      end

      private

      def connection
        Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
          faraday.options.timeout = 3
          faraday.options.open_timeout = 2
        end
      end
    end
  end
end
