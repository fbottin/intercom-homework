describe File do
  it 'includes the public method read_customers_file' do
    expect(File).to respond_to(:read_customers_file)
  end

  describe '#read_customers_file' do
    subject do
      described_class.read_customers_file(
        file_location, ignore_errors: ignore_errors
      )
    end

    let(:file_location) { 'file_location' }
    let(:ignore_errors) { false           }
    let(:valid_response) do
      [
        {
          'latitude' => '52.986375', 'user_id' => 12,
          'name' => 'Christina McArdle', 'longitude' => '-6.043701'
        },
        {
          'latitude' => '51.92893', 'user_id' => 1,
          'name' => 'Alice Cahill', 'longitude' => '-10.27699'
        }
      ]
    end

    before do
      allow(File).to receive(:readlines).with(file_location)
        .and_return(array_of_lines)
    end

    context 'when file is well formatted' do
      let(:array_of_lines) do
        ["{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n",
         "{\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n"]
      end

      it 'returns the array of costumers' do
        is_expected.to eq(valid_response)
      end
    end

    context 'when the file is not well formatted' do
      let(:array_of_lines) do
        ["{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n",
         "\n",
         "{\"wrong json\"}",
         "{\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n"]
      end

      context "when don't want to ignore errors" do
        it 'raises an error' do
          expect { subject }.to raise_error(JSON::ParserError)
        end
      end

      context "when want to ignore errors" do
        let(:ignore_errors) { true }

        it 'returns the array of the customers that could been collected' do
          is_expected.to eq(valid_response)
        end
      end
    end
  end

  describe '#write_customers_to_file' do
    subject(:write_customers_to_file) do
      described_class.write_customers_to_file(file_output, customers)
    end

    let(:file_output) { 'file_location' }
    let(:customers) do
      [
        {
          'latitude' => '51.92893', 'user_id' => 1,
          'name' => 'Alice Cahill', 'longitude' => '-10.27699'
        },
        {
          'latitude' => '52.986375', 'user_id' => 12,
          'name' => 'Christina McArdle', 'longitude' => '-6.043701'
        }
      ]
    end
    let(:file) { instance_double(File) }

    before do
      allow(File).to receive(:open).with(file_output, 'w').and_return(file)
      allow(file).to receive(:puts)
      allow(file).to receive(:close).and_return(nil)
    end

    before { write_customers_to_file }

    it 'opens the right file to write' do
      expect(File).to have_received(:open).with(file_output, 'w').once
    end

    it 'writes the customers in the file' do
      customers.each do |c|
        msg = "#{c['user_id']}, #{c['name']}"
        expect(file).to have_received(:puts).with(msg)
      end
    end

    it 'closes the file after writing' do
      expect(file).to have_received(:close).once
    end
  end
end