# frozen_string_literal: true

module SharePricesHelper
  def dollar_value(price)
    sprintf("%0.2f", price)
  end
end
