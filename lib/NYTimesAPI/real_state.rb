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
      def enable_url_for(resource_type, query_type)
        return "http://api.nytimes.com/svc/real-estate/#{API_VERSION}/#{resource_type}/#{query_type}/50.json?geo-extent-level=borough&"
      end
    end

    attr_accessor :api_key, :requests_count

    def initialize(api_key)
      @api_key = api_key
      @requests_count = 0
    end

    def counts(location, options)
      base_url = RealState.enable_url_for("listings", "count")

      geo_summary_level = options[:geo_summary_level] || GEO_SUMMARY_LEVELS.first
      url = "#{base_url}geo-extent-value=#{location}&geo-summary-level=#{geo_summary_level}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"

      json = NYTimesAPI::Util.get_json(url)
      self.requests_count += 1

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

    def percentiles(location, options={})
      base_url = RealState.enable_url_for("listings", "percentile")

      url = "#{base_url}geo-extent-value=#{location}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"
      json = NYTimesAPI::Util.get_json(url)
      self.requests_count += 1

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

    def sales_percentiles(location, options={})
      base_url = RealState.enable_url_for("sales", "percentile")

      geo_summary_level = options[:geo_summary_level] || GEO_SUMMARY_LEVELS.first
      url = "#{base_url}geo-extent-value=#{location}&geo-summary-level=#{geo_summary_level}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"

      json = NYTimesAPI::Util.get_json(url)
      self.requests_count += 1

      results = []

      if json["status"] == SUCCESS
        json["results"].each do |res|

          result_item = {
            zip: res["zip"],
            date_format: res["date_format"],
            date: res["date"],
            percentile: res["percentile"],
            sale_price: res["sale_price"]
          }

          results.push result_item
        end
      end

      return results
    end

    def sales_counts(location, options={})
      base_url = RealState.enable_url_for("sales", "count")

      geo_summary_level = options[:geo_summary_level] || GEO_SUMMARY_LEVELS.first
      url = "#{base_url}geo-extent-value=#{location}&geo-summary-level=#{geo_summary_level}&date-range=#{options[:date]}&bedrooms=#{options[:bedrooms]}&building-type-id=#{options[:type]}&api-key=#{self.api_key}"

      json = NYTimesAPI::Util.get_json(url)
      self.requests_count += 1

      results = []

      if json["status"] == SUCCESS
        json["results"].each do |res|

          result_item = {
            neighborhood: res["neighborhood"],
            date_format: res["date_format"],
            date: res["date"],
            count: res["count"]
          }

          results.push result_item
        end
      end

      return results
    end
  end
end
