RSpec.describe Tellus::Google::Client do
  it "has a version number" do
    expect(Tellus::Google::Client::VERSION).not_to be nil
  end

  describe '.sign_url' do
    let(:url) { Faker::Internet.url }
    subject { described_class.sign_url(url) }

    it "doesn't modify the URL" do
      expect(subject).to start_with url
    end

    it 'adds a signature param to end of the URL' do
      expect(subject).to match(/signature=[0-9a-zA-Z_-]+=\Z/)
    end

    context 'with a specific URL' do
      let(:url) { 'https://test.example.com?hello=world&foo=bar' }

      it 'creates the right signature' do
        expect(subject).to eql "#{url}&signature=1X_r4V7CdTe6mf8T54MSVbyJc_4="
      end
    end
  end

  describe '.maps_api_script_url' do
    let(:callback) { nil }

    subject { described_class.maps_api_script_url(callback: callback) }

    context 'without callback' do
      it 'returns a URL with callback query string' do
        expect(subject).to eq(
          'https://maps.googleapis.com/maps/api/js?key=test'
        )
      end
    end

    context 'with callback' do
      let(:callback) { 'testCallback' }

      it 'returns a URL without a callback query string' do
        expect(subject).to eq(
          'https://maps.googleapis.com/maps/api/js?callback=testCallback&key=test'
        )
      end
    end
  end
end
