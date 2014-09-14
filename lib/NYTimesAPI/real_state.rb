module NYTimesAPI
  class RealState
    API_VERSION = "v2"
    BASE_URL = "http://api.nytimes.com/svc/real-estate/#{API_VERSION}/listings/percentile/50.json?geo-extent-level=borough&"

    SUCCESS = "OK"

    GEO_SUMMARY_LEVELS = %w(borough neighborhood zip)

    BUILDING_TYPES = {
      "Apartments" => 2
    }

    class << self
      def enable_url_for(query_type)
        return "http://api.nytimes.com/svc/real-estate/#{API_VERSION}/listings/#{query_type}/50.json?geo-extent-level=borough&"
      end
    end

    attr_accessor :api_key, :requests_count

    def initialize(api_key)
      @api_key = api_key
      @requests_count = 0
    end

    def count(location, options)
      base_url = RealState.enable_url_for("count")

      geo_summary_level = options[:geo_summary_level] || GEO_SUMMARY_LEVELS.first
      url = "#{base_url}geo-extent-value=#{location}&geo-summary-level=#{geo_summary_level}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"

      json = NYTimesAPI::Util.get_json(url)

      results = []

      if json["status"] == SUCCESS
        json["results"].each do |res|

          result_item = {
            borough: res["borough"],
            date_format: res["date_format"],
            date: res["date"],
            count: res["count"]
          }

          results.push result_item
        end
      end

      return results
    end

    def percentile(location, options={})
      base_url = RealState.enable_url_for("percentile")

      url = "#{base_url}geo-extent-value=#{location}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"
      json = NYTimesAPI::Util.get_json(url)

      results = []

      if json["status"] == SUCCESS
        json["results"].each do |res|

          result_item = {
            borough: res["borough"],
            date_format: res["date_format"],
            date: res["date"],
            percentile: res["percentile"],
            listing_price: res["listing_price"]
          }

          results.push result_item
        end
      end

      return results
    end
  end
end
