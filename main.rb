#!/usr/bin/env ruby

require_relative('lib/core_ext/file')
require_relative('lib/select_customers')

def run_selection(input, output, lat, long, range, field, order)
  customers = File.read_customers_file(input)

  select_customers = SelectCustomers.new(customers, lat, long)
  select_customers.select_in_range(range: range)
  select_customers.sort(field: field, order: order)

  File.write_customers_to_file(output, select_customers.customers)
end

input_file  = ARGV[0]  || 'customers.txt'
output_file = ARGV[1]  || 'output.txt'
latitude    = (ARGV[2] || 53.339428).to_f
longitude   = (ARGV[3] || -6.257664).to_f
range       = (ARGV[4] || 100.00).to_f
field       = ARGV[5]  || 'user_id'
order       = (ARGV[6] || :asc).to_sym

run_selection(input_file, output_file, latitude, longitude, range, field, order)

puts "That's all folks!"