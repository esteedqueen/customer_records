# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/distance_between'

class TestDistanceBetween < Test::Unit::TestCase
  def distance_between
    lagos = 6.465422, 3.406448
    dublin = 53.339428, -6.257664
    DistanceBetween.new(lagos, dublin)
  end

  def test_calculate
    assert_equal(distance_between.calculate, 5285.250)

    assert_raise ArgumentError do
      DistanceBetween.new('Lagos', 'Dublin').calculate
    end
  end
end
