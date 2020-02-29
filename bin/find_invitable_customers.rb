# frozen_string_literal: true

require_relative '../lib/customer_records'

destination = ARGV[0] || 53.339428, -6.257664
customer_records_file = ARGV[1] || 'input.txt'

CustomerRecords.new(
	records_file: customer_records_file,
	destination: destination
).retrieve_invitable
