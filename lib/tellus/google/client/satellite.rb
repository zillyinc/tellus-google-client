module Tellus
  module Google
    module Client
      class Satellite < ImageBase
        BASE_URL = "#{MAPS_API_BASE_URL}/staticmap".freeze
        MAPTYPE = 'satellite'.freeze
        ZOOM = 20

        def query_params
          {
            maptype: MAPTYPE,
            center: coordinates,
            zoom: ZOOM,
            size: SIZE
          }
        end
      end
    end
  end
end
