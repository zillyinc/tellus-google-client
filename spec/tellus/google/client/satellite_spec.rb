require "tellus/google/client/satellite"
require "tellus/google/coordinates"

RSpec.describe Tellus::Google::Client::Satellite do
  subject { described_class.new(params) }

  describe '#image_url' do
    context 'with address param' do
      let(:params) { { address: Faker::Address.full_address } }
      before { WebStub::Google.stub_geocode }

      it 'returns a valid google image URL' do
        expect(subject.image_url).to match(
          Regexp.new('\Ahttps://maps.googleapis.com/maps/api/staticmap\?center=-?[0-9\.]+%2C-?[0-9\.]+&key=[0-9a-zA-Z-]+&maptype=satellite&size=[0-9]+x[0-9]+&zoom=[0-9]+&signature=-?[0-9a-zA-Z_-]+=?\Z')
        )
      end
    end

    context 'with coordinates param' do
      let(:params) { { coordinates: Tellus::Google::Coordinates.new(42, -42) } }

      it 'returns a valid google image URL' do
        expect(subject.image_url).to match(
          Regexp.new('\Ahttps://maps.googleapis.com/maps/api/staticmap\?center=-?[0-9\.]+%2C-?[0-9\.]+&key=[0-9a-zA-Z-]+&maptype=satellite&size=[0-9]+x[0-9]+&zoom=[0-9]+0&signature=-?[0-9a-zA-Z_-]+=?\Z')
        )
      end
    end
  end
end
