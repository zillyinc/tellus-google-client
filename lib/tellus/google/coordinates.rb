require 'json'

module Tellus
  module Google
    class Coordinates
      attr_reader :lat, :lon

      def initialize(lat, lon)
        @lat = lat.to_f
        @lon = lon.to_f
      end

      alias latitude lat
      alias longitude lon
      alias lng lon

      def to_a
        [lat, lon]
      end

      def to_hash
        # NOTE: This is current only to support Google maps which uses lng, not lon
        { lat: lat, lng: lon }
      end

      def to_json
        to_hash.to_json
      end

      def to_s
        to_a.join(',')
      end

      def blank?
        lat.zero? && lon.zero?
      end

      def present?
        !blank?
      end

      def presence
        blank? ? nil : self
      end
    end
  end
end
