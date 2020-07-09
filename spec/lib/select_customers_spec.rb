RSpec::Matchers.define :have_attr_reader do |field|
  match do |object_instance|
    object_instance.respond_to?(field) &&
      !object_instance.respond_to?("#{field}=")
  end

  failure_message do |object_instance|
    "expected attr_reader for #{field} on #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected attr_reader for #{field} not to be defined on #{object_instance}"
  end

  description do
    'assert there is an attr_reader of the given name on the supplied object'
  end
end

describe SelectCustomers do
  subject(:select_customers) do
    described_class.new(customers, lat_origin, long_origin)
  end

  let(:customers) do
    [
      {
        'latitude' => '52.986375', 'user_id' => 12,
        'name' => 'Christina McArdle', 'longitude' => '-6.043701'
      },
      {
        'latitude' => '53.1302756', 'user_id' => 5,
        'name' => 'Nora Dempsey', 'longitude' => '-6.2397222'
      },
      {
        'latitude' => '51.92893', 'user_id' => 1,
        'name' => 'Alice Cahill', 'longitude' => '-10.27699'
      }
    ]
  end
  let(:lat_origin)  { 53.339428 }
  let(:long_origin) { -6.257664 }

  it { is_expected.to have_attr_reader(:customers) }

  describe '#select_in_range' do
    subject { select_customers.select_in_range(range: range) }

    let(:range) { 100.00 }
    let(:customer_inside_range) do
      [
        {
          'latitude' => '52.986375', 'user_id' => 12,
          'name' => 'Christina McArdle', 'longitude' => '-6.043701'
        },
        {
          'latitude' => '53.1302756', 'user_id' => 5,
          'name' => 'Nora Dempsey', 'longitude' => '-6.2397222'
        }
      ]
    end

    it 'returns only clients inside the required range' do
      is_expected.to eq(customer_inside_range)
    end
  end

  describe '#sort' do
    subject { select_customers.sort(field: field, order: order) }

    let(:field) { 'user_id' }
    let(:customers_sorted) do
      [
        {
          'latitude' => '51.92893', 'user_id' => 1,
          'name' => 'Alice Cahill', 'longitude' => '-10.27699'
        },
        {
          'latitude' => '53.1302756', 'user_id' => 5,
          'name' => 'Nora Dempsey', 'longitude' => '-6.2397222'
        },
        {
          'latitude' => '52.986375', 'user_id' => 12,
          'name' => 'Christina McArdle', 'longitude' => '-6.043701'
        }
      ]
    end

    context 'when required order asc' do
      let(:order) { :asc }

      it 'returns customers in asc order' do
        is_expected.to eq(customers_sorted)
      end
    end

    context 'when required order asc' do
      let(:order) { :desc }

      it 'returns customers in asc order' do
        is_expected.to eq(customers_sorted.reverse)
      end
    end
  end
end