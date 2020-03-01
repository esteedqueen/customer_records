# frozen_string_literal: true

require 'json'
require_relative 'distance_between'

class CustomerRecords
  def initialize(records_file:, destination:)
    @customer_records_file = records_file
    @customers = all_customers
    @destination = destination
  end

  # read all customer records from file
  def all_customers
    if @customer_records_file.nil? || !File.exist?(@customer_records_file)
      raise ArgumentError, 'Customer records file must be provided'
    end

    File.open(@customer_records_file, 'r') do |f|
      f.each_line.map do |line|
        JSON.parse(line)
      end
    end
  end

  # calculate distance from destination
  def calculate_distance_from_destination_for_all
    if @destination.nil?
      raise ArgumentError, 'Destination coordinates must be provided'
    end

    @customers.each do |customer|
      if valid_record?(customer)
        customer_lat_long = customer['latitude'], customer['longitude']
      end
      destination_lat_long = @destination[0], @destination[1]
      distance_between = DistanceBetween.new(customer_lat_long, destination_lat_long).calculate
      add_distance_to_customer_records(customer, distance_between)
    end
  end

  def invitable_customers
    calculate_distance_from_destination_for_all

    invitable_customers = find_by(distance_within: 100)
    invitable_customers.map do |hash|
      hash.select { |key| key.match(/name|user_id/) }
    end
  end

  private

  # update customer records with distance from destination value
  def add_distance_to_customer_records(customer, calculated_distance)
    customer['distance_from_destination_in_radians'] = calculated_distance
  end

  # retrieve customer records by distance from destination
  def find_by(distance_within:)
    if distance_within.nil?
      raise ArgumentError, 'Distance within must be provided'
    end

    # select and sort matching customers
    @customers.select do |customer_hash|
      customer_hash['distance_from_destination_in_radians'] <= distance_within
    end.sort_by { |hash| hash['user_id'] }
  end

  def valid_record?(customer)
    valid = %w[name user_id latitude longitude].all? { |k| customer.key? k }

    unless valid
      raise ArgumentError, 'Input is invalid - see input.txt as sample'
    end

    valid
  end
end
