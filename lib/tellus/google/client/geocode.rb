require 'httparty'

module Tellus
  module Google
    module Client
      class Geocode
        URL = "#{MAPS_API_BASE_URL}/geocode/json".freeze

        def initialize(address)
          @address = address
        end

        def coordinates
          @coordinates ||= Coordinates.new(location['lat'], location['lng'])
        end

        private

        attr_reader :address

        def response
          @response ||= HTTParty.get(URL, query: { address: address })
        end

        def location
          @location ||= begin
            top_result = response.fetch('results', []).first || {}
            top_result.dig('geometry', 'location') || {}
          end
        end
      end
    end
  end
end
