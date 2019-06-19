module Tellus
  module Google
    module Client
      class StreetView < ImageBase
        BASE_URL = "#{MAPS_API_BASE_URL}/streetview".freeze
        METADATA_URL = "#{BASE_URL}/metadata".freeze
        FORMAT = 'jpg'.freeze
        OK_STATUS = 'OK'.freeze

        def initialize(address: nil, coordinates: nil)
          raise ArgumentError, 'address is required' if address.blank?

          super
        end

        def query_params
          {
            location: address,
            size: SIZE,
            format: FORMAT
          }
        end

        private

        def exists?
          @exists ||= begin
            HTTParty.get(METADATA_URL, query: {
                          location: address, key: API_KEY
                        }).fetch('status') == OK_STATUS
          end
        end
      end
    end
  end
end
