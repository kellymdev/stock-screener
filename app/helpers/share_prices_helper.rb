# frozen_string_literal: true

module SharePricesHelper
  def dollar_value(price)
    if price.present?
      sprintf("%0.2f", price)
    else
      '0.00'
    end
  end
end
