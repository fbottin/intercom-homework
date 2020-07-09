describe GeoCalculator do
  describe '#distance' do
    subject { described_class.distance(lat1, long1, lat2, long2) }
    
    let(:lat1)  { 53.339428 }
    let(:long1)  { -6.257664 }

    context 'when the two points are far apart' do
      let(:lat2) { 51.92893 }
      let(:long2) { -10.27699 }

      it 'returns the distance in kilometers ' do
        is_expected.to be_within(0.01).of(313.25)
      end
    end

    context 'when the two points are very close' do
      let(:lat2) { 53.338995 }
      let(:long2) { -6.258387 }

      it 'returns the distance in kilometers ' do
        is_expected.to be_within(0.01).of(0.067)
      end
    end
  end
end