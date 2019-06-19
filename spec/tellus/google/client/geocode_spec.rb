require "tellus/google/client/geocode"
require "tellus/google/coordinates"

RSpec.describe Tellus::Google::Client::Geocode do
  let(:address) { Faker::Address.full_address }
  subject { described_class.new(address) }

  before { WebStub::Google.stub_geocode 42, -42 }

  describe '#coordinates' do
    it 'returns a Coordinates object' do
      expect(subject.coordinates).to be_a Tellus::Google::Coordinates
      expect(subject.coordinates.latitude).to eql 42.0
      expect(subject.coordinates.longitude).to eql(-(42.0))
    end
  end
end
