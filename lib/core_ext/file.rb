require('json')

class File
  # Reads and convert the lines of a file to JSON
  # Accepts a boolean parameter `ignore_errors` to ignore parse errors
  # and return customers that can be parsed 
  def self.read_customers_file(file_location, ignore_errors: false)
    convert_to_json = -> (l) { convert_line_to_json(l, ignore_errors) }

    File.readlines(file_location).map(&convert_to_json).compact
  end

  # Open or create a file and writes the customers on it
  # The customers are formatted as `user_id, name`
  def self.write_customers_to_file(file_output, selected_customers)
    file = File.open(file_output, 'w')
    selected_customers.each { |c| file.puts("#{c['user_id']}, #{c['name']}") }
    file.close
  end

  private

  def self.convert_line_to_json(line, ignore_errors)
    JSON.parse(line)
  rescue JSON::ParserError => error
    return nil if ignore_errors
    raise JSON::ParserError.new('Bad File Format: ' + error.to_s)
  end
end