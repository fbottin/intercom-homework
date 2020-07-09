require_relative '../main'

describe '#run_selection' do
  subject(:run_selection_method) do
    run_selection(input, output, lat, long, range, field, order)
  end

  let(:input)  { 'customers.txt' }
  let(:output) { 'output.txt'    }
  let(:lat)    { 53.339428       }
  let(:long)   { -6.257664       }
  let(:range)  { 100.00          }
  let(:field)  { 'user_id'       }
  let(:order)  { :asc            }
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
  let(:valid_customers) do
    [
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

  before do
    allow(File).to receive(:read_customers_file).with(input)
      .and_return(customers)
    allow(File).to receive(:write_customers_to_file)
      .with(output, valid_customers).and_return(nil)
    
    run_selection_method
  end

  it 'reads the right file' do
    expect(File).to have_received(:read_customers_file).with(input).once
  end

  it 'writes the right customers to the output file' do
    expect(File).to have_received(:write_customers_to_file)
      .with(output, valid_customers).once
  end

end