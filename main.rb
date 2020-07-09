#!/usr/bin/env ruby

require('getoptlong')
require_relative('run')

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--output', '-o', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--lat', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--long', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--range', '-r', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--field', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--order', GetoptLong::OPTIONAL_ARGUMENT ]
)

def help
  puts <<-EOF
    -h, --help:
      show help
    -i, --input:
      change the input file with customers list.
        Default `customers.txt`
    -o, --output:
      change the output file for the selected customers list.
        Default `output.txt`
    --lat:
      change the latitude.
        Default `53.339428`
    --long:
      change the longitude.
        Default `-6.257664`
    -r, --range:
      change the range in km.
        Default `100.00` km
    -f, --field:
      change the field used to sort the results.
        Default `user_id`
    --order:
      change the sort order.
        Default `asc`
  EOF
end

input_file  = 'customers.txt'
output_file = 'output.txt'
latitude    = 53.339428
longitude   = -6.257664
range      = 100.00
field       = 'user_id'
order       = :asc

opts.each do |opt, arg|
  case opt
  when '--help'
    help
  when '--input'
    input_file = arg unless arg.empty?
  when '--output'
    output_file = arg unless arg.empty?
  when '--lat'
    latitude = arg.to_f unless arg.empty?
  when '--long'
    longitude = arg.to_f unless arg.empty?
  when '--range'
    range = arg.to_f unless arg.empty?
  when '--field'
    field = arg unless arg.empty?
  when '--order'
    order = arg.to_sym unless arg.empty?
  end
end

Run.selection(
  input_file, output_file, latitude, longitude, range, field, order
)

puts "That's all folks!"