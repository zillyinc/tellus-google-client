module Tellus
  module Google
    module Client
      class ImageBase
        SIZE = '800x400'.freeze

        def initialize(address: nil, coordinates: nil)
          raise ArgumentError unless coordinates.nil? || coordinates.is_a?(Tellus::Google::Coordinates)
          raise ArgumentError, 'Must provide address or coordinates' if address.nil? && coordinates.nil?

          @address = address
          @coordinates = coordinates.presence
        end

        def image_url
          raise ArgumentError unless defined? self.class::BASE_URL
          return nil unless exists?

          query = query_params.merge(key: API_KEY).to_query

          Client.sign_url("#{self.class::BASE_URL}?#{query}")
        end

        private

        attr_reader :address

        # If coordinates is not set, get them from the address
        def coordinates
          @coordinates ||= Geocode.new(address).coordinates
        end

        def query_params
          raise NotImplementedError
        end

        def exists?
          coordinates.present?
        end
      end
    end
  end
end
