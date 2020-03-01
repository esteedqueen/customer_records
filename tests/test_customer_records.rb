# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/customer_records'

class TestCustomerRecords < Test::Unit::TestCase
  def test_all_customers
    assert_equal(expected_customers, customer_records.all_customers)

    assert_raise ArgumentError do
      CustomerRecords.new(
        records_file: '',
        destination: destination
      ).all_customers
    end
  end

  def test_calculate_distance_from_destination
    customers = customer_records.calculate_distance_from_destination_for_all
    assert_equal(expected_customers_with_distance, customers)

    assert_raise ArgumentError do
      CustomerRecords.new(
        records_file: 'tests/fixtures/invalid_record.txt',
        destination: destination
      ).calculate_distance_from_destination_for_all
    end

    assert_raise ArgumentError do
      CustomerRecords.new(
        records_file: 'tests/fixtures/records.txt',
        destination: nil
      ).calculate_distance_from_destination_for_all
    end
  end

  def test_invitable_customers
    invitable_customers = customer_records.invitable_customers
    assert_equal(expected_invitable_customers, invitable_customers)

    assert_raise ArgumentError do
      CustomerRecords.new(
        records_file: 'test/fixtures/records.txt',
        destination: nil
      ).invitable_customers
    end
  end

  def customer_records
    CustomerRecords.new(
      records_file: 'tests/fixtures/records.txt',
      destination: destination
    )
  end

  def destination
    [53.339428, -6.257664]
  end

  def expected_customers
    [{ 'latitude' => '52.986375',
       'user_id' => 12,
       'name' => 'Grace Hopper',
       'longitude' => '-6.043701' },
     { 'latitude' => '51.92893',
       'user_id' => 1,
       'name' => 'Ada Lovelace',
       'longitude' => '-10.27699' }]
  end

  def expected_invitable_customers
    [{ 'user_id' => 12, 'name' => 'Grace Hopper' }]
  end

  def expected_customers_with_distance
    [{ 'latitude' => '52.986375',
       'user_id' => 12,
       'name' => 'Grace Hopper',
       'longitude' => '-6.043701',
       'distance_from_destination_in_radians' => 41.77 },
     { 'latitude' => '51.92893',
       'user_id' => 1,
       'name' => 'Ada Lovelace',
       'longitude' => '-10.27699',
       'distance_from_destination_in_radians' => 313.26 }]
  end
end
