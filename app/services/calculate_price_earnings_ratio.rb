# frozen_string_literal: true

class CalculatePriceEarningsRatio
  attr_reader :year, :stock

  def initialize(year, stock)
    @year = year
    @stock = stock
  end

  def call
    return unless price && earning_value

    {
      high_pe_ratio: calculate_pe_ratio(price.high_value, earning_value),
      low_pe_ratio: calculate_pe_ratio(price.low_value, earning_value)
    }
  end

  private

  def calculate_pe_ratio(price_amount, earning_amount)
    price_amount / earning_amount
  end

  def price
    stock.share_prices.where(year: year).first
  end

  def earning_value
    stock.earnings.where(year: year).first&.value
  end
end
