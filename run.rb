require_relative('lib/core_ext/file')
require_relative('lib/select_customers')

module Run
  def self.selection(input, output, lat, long, range, field, order)
    customers = File.read_customers_file(input)

    select_customers = SelectCustomers.new(customers, lat, long)
    select_customers.select_in_range(range: range)
    select_customers.sort(field: field, order: order)

    File.write_customers_to_file(output, select_customers.customers)
  end
end
