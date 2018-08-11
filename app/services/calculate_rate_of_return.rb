# frozen_string_literal: true

class CalculateRateOfReturn
  attr_reader :present_value, :future_value, :number_of_years

  def initialize(present_value, future_value, number_of_years)
    @present_value = present_value
    @future_value = future_value
    @number_of_years = number_of_years
  end

  def call
    ratio = present_to_future_value_ratio
    calculate_rate(ratio)
  end

  private

  def present_to_future_value_ratio
    present_value / future_value
  end

  def calculate_rate(ratio)
    rate = (ratio ** -(1 / number_of_years.to_d)) - 1
    rate.round(2) * 100
  end
end
