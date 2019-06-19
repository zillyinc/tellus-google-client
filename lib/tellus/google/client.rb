require "tellus/google/client/version"

module Tellus
  module Google
    module Client
      class Error < StandardError; end

      API_KEY = ENV['GOOGLE_API_KEY'].freeze
      SIGNING_SECRET = ENV['GOOGLE_SIGNING_SECRET'].freeze
      MAPS_API_BASE_URL = 'https://maps.googleapis.com/maps/api'.freeze
      EMBEDDED_MAP_API_KEY = ENV['GOOGLE_EMBEDDED_MAP_API_KEY'].freeze
      MAPS_API_SCRIPT_BASE_URL = 'https://maps.googleapis.com/maps/api/js'.freeze
      MAPS_DEFAULT_ZOOM = 15

      # For details see https://developers.google.com/maps/documentation/static-maps/get-api-key
      def self.sign_url(url)
        uri = URI.parse(url)
        # URLs are signed without the hostname
        url_to_sign = "#{uri.path}?#{uri.query}"

        signature = OpenSSL::HMAC.digest('sha1', Base64.urlsafe_decode64(SIGNING_SECRET), url_to_sign)

        "#{url}&signature=#{Base64.urlsafe_encode64(signature)}"
      end

      def self.maps_api_script_url(callback: nil)
        uri = URI.parse(MAPS_API_SCRIPT_BASE_URL)

        query = { key: EMBEDDED_MAP_API_KEY }
        query[:callback] = callback if callback
        uri.query = query.to_query

        uri.to_s
      end
    end
  end
end

require "tellus/google/coordinates"
require "tellus/google/client/geocode"
require "tellus/google/client/image_base"
require "tellus/google/client/satellite"
require "tellus/google/client/street_view"
require "json"
require "active_support/core_ext/hash"
require "active_support/core_ext/object/blank"
