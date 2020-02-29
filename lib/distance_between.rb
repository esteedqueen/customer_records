# frozen_string_literal: true

class DistanceBetween
  EARTH_RADIUS_IN_KM = 6371.0

  def initialize(point_a, point_b)
    unless valid_arguments?(point_a, point_b)
      raise ArgumentError, 'Please provide valid starting & destination points'
    end

    @starting_coordinates = to_radians(point_a[0]), to_radians(point_a[1])
    @destination_coordinates = to_radians(point_b[0]), to_radians(point_b[1])
  end

  def calculate
    # calculate central angle using coordinates and lat/lng deltas
    angle = (Math.sin(latitude_delta / 2)**2) +
            (Math.cos(@starting_coordinates[0]) *
              Math.cos(@destination_coordinates[0])) *
            (Math.sin(longitude_delta / 2)**2)
    c = 2 * Math.atan2(Math.sqrt(angle), Math.sqrt(1 - angle))

    distance = c * EARTH_RADIUS_IN_KM
    distance.round(2)
  end

  private

  # calculate latitude_delta
  def latitude_delta
    @starting_coordinates[0] - @destination_coordinates[0]
  end

  # calculate longitude_delta
  def longitude_delta
    @starting_coordinates[1] - @destination_coordinates[1]
  end

  # convert degrees to radians
  def to_radians(coordinates)
    coordinates.to_f * (Math::PI / 180)
  end

  def valid_arguments?(point_a, point_b)
    point_a.is_a?(Array) && point_b.is_a?(Array)
  end
end
