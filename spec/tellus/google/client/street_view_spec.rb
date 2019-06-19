require "tellus/google/client/satellite"
require "tellus/google/coordinates"

RSpec.describe Tellus::Google::Client::StreetView do
  subject { described_class.new(params) }

  describe '#image_url' do
    context 'with address param' do
      let(:params) { { address: Faker::Address.full_address } }
      before do
        WebStub::Google.stub_geocode
        WebStub::Google.stub_streetview_metadata
      end

      it 'returns a valid google image URL' do
        expect(subject.image_url).to match(
          Regexp.new('\Ahttps://maps.googleapis.com/maps/api/streetview\?format=jpg&key=[0-9a-zA-Z-]+&location=.+&size=[0-9]+x[0-9]+&signature=-?[0-9a-zA-Z_-]+=?\Z')
        )
      end
    end

    context 'without address param' do
      let(:params) { { coordinates: Tellus::Google::Coordinates.new(42, -42) } }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
