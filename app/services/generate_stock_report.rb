# frozen_string_literal: true

class GenerateStockReport
  attr_reader :stock

  def initialize(stock)
    @stock = stock
  end

  def call
    data = {}

    years_for_report.reverse.each do |year_num|
      data[year_num] = data_for_year(year_num)
    end

    {
      generated_at: Time.now.to_s,
      report_data: data,
      report_summary: create_report_summary(data)
    }
  end

  private

  def years_for_report
    years_with_prices = stock.share_prices.joins(:year).pluck("years.year_number").sort.reverse

    years = years_with_prices.select {|year_num| stock.can_generate_report?(year_num) }

    find_consecutive_years(years)
  end

  def find_consecutive_years(year_numbers)
    years = []

    year_numbers.each.with_index do |year, index|
      if index.zero? || consecutive_year?(year, year_numbers[index - 1])
        years << year
      else
        return years
      end
    end

    years
  end

  def consecutive_year?(year1, year2)
    year1 + 1 == year2
  end

  def data_for_year(year_number)
    price = stock.share_prices.for_year(year_number).first
    earnings = stock.earnings.for_year(year_number).first.value
    dividends = stock.dividends.for_year(year_number).sum(:value)

    year = Year.find_by(year_number: year_number)
    pe_ratio = calculate_pe_ratio_for(year)
    retained_earnings = calculate_retained_earnings(earnings, dividends)

    {
      high_price: price.high_value,
      low_price: price.low_value,
      high_pe_ratio: pe_ratio[:high_pe_ratio],
      low_pe_ratio: pe_ratio[:low_pe_ratio],
      earnings: earnings,
      total_dividends: dividends,
      retained_earnings: retained_earnings
    }
  end

  def calculate_retained_earnings(earning_value, dividend_value)
    earning_value - dividend_value
  end

  def calculate_pe_ratio_for(year)
    CalculatePriceEarningsRatio.new(year, stock).call
  end

  def create_report_summary(data)
    {
      total_dividends: sum_data(data, :total_dividends),
      total_retained_earnings: sum_data(data, :retained_earnings)
    }
  end

  def sum_data(data, key)
    data.map do |year_data|
      year_data.second[key]
    end.reduce(:+)
  end
end
