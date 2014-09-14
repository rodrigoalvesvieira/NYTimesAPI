module NYTimesAPI
  class Util
    class << self

      def get_json(url)
        url = URI.encode(url)
        uri = URI.parse(url)

        json = JSON.parse(Net::HTTP.get_response(uri).body)
      end
    end
  end
end
