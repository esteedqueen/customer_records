# frozen_string_literal: true

require_relative '../lib/customer_records'

destination = ARGV[0] || 53.339428, -6.257664
customer_records_file = ARGV[1] || 'input.txt'

invitable_customers = CustomerRecords.new(
  records_file: customer_records_file,
  destination: destination
).invitable_customers

File.open('output.txt', 'w') { |file| file.puts invitable_customers }

puts 'Here are the invitable customers:'
puts 'Output available in output.txt'
puts invitable_customers
