require "tellus/google/coordinates"

RSpec.describe Tellus::Google::Coordinates do
  let(:lat) { Faker::Address.latitude.to_f }
  let(:lon) { Faker::Address.longitude.to_f }

  subject { Tellus::Google::Coordinates.new(lat, lon) }

  describe '#lat' do
    it { expect(subject.lat).to eql lat }
  end

  describe 'lon' do
    it { expect(subject.lon).to eql lon }
  end

  describe '#to_a' do
    it { expect(subject.to_a).to eql [lat, lon] }
  end

  describe '#to_hash' do
    it 'returns a hash with lat and lng keys' do
      expect(subject.to_hash).to eq({lat: lat, lng: lon})
    end
  end

  describe '#to_json' do
    let(:lat) { 4.2 }
    let(:lon) { -4.2 }

    it 'returns a JSON string with lat and lng keys' do
      expect(subject.to_json).to eq '{"lat":4.2,"lng":-4.2}'
    end
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eql "#{lat},#{lon}" }
  end

  describe '#blank?' do
    context 'when lat and lon are nil' do
      let(:lat) { nil }
      let(:lon) { nil }

      it { expect(subject).to be_blank }
    end

    context 'when lat and lon are present' do
      it { expect(subject).to_not be_blank }
    end
  end

  describe '#present?' do
    context 'when lat and lon are nil' do
      let(:lat) { nil }
      let(:lon) { nil }

      it { expect(subject).to_not be_present }
    end

    context 'when lat and lon are present' do
      it { expect(subject).to be_present }
    end
  end

  describe '#presence' do
    context 'when lat and lon are nil' do
      let(:lat) { nil }
      let(:lon) { nil }

      it { expect(subject.presence).to be nil }
    end

    context 'when lat and lon are present' do
      it { expect(subject.presence).to eql subject }
    end
  end
end
