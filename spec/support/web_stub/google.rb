module WebStub
  module Google
    def self.stub_geocode(lat = Faker::Address.latitude, lon = Faker::Address.longitude)
      WebMock.stub_request(
        :get,
        Regexp.new('^https?://maps\.googleapis\.com/maps/api/geocode/json')
      ).to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: {
          results: [
            geometry: {
              location: {
                lat: lat,
                lng: lon
              }
            }
          ]
        }.to_json
      )
    end

    def self.stub_streetview
      WebMock.stub_request(
        :get,
        Regexp.new('^https://maps\.googleapis\.com/maps/api/streetview/?\?')
      ).to_return(body: Rails.root.join('spec', 'fixtures', 'streetview.jpg'))
    end

    def self.stub_streetview_metadata(status = Tellus::Google::Client::StreetView::OK_STATUS)
      WebMock.stub_request(
        :get,
        Regexp.new('^https://maps\.googleapis\.com/maps/api/streetview/metadata')
      ).to_return(
        headers: { 'Content-Type' => 'application/json' },
        body: { status: status }.to_json
      )
    end

    def self.stub_static_map
      WebMock.stub_request(
        :get,
        Regexp.new('^https://maps\.googleapis\.com/maps/api/staticmap\?.*')
      ).to_return(body: Rails.root.join('spec', 'fixtures', 'staticmap.png'))
    end

    def self.stub_recaptcha(success, captcha_response, ip)
      secret = ENV['GOOGLE_RECAPTCHA_SECRET']
      WebMock.stub_request(
        :post,
        'https://www.google.com/recaptcha/api/siteverify'
      ).with(
        body: "remoteip=#{ip}&response=#{captcha_response}&secret=#{secret}"
      ).to_return(
        status: 200,
        headers: { 'Content-Type': 'application/json' },
        body: {
          success: success,
        }.to_json
      )
    end
  end
end
