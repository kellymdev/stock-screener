# frozen_string_literal: true

class GenerateStockReport
  attr_reader :stock, :current_price, :government_bond_interest_rate, :first_year, :last_year

  def initialize(stock, report_params)
    @stock = stock
    @current_price = report_params[:current_price].to_d
    @government_bond_interest_rate = report_params[:government_bond_interest_rate].to_d
  end

  def call
    data = {}

    years = years_for_report.reverse
    @first_year = years.first
    @last_year = years.last

    years.each do |year_num|
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
    return {} unless data.present?

    dividends = sum_data(data, :total_dividends)
    retained_earnings = sum_data(data, :retained_earnings)
    dividend_percentage = calculate_dividend_percentage(dividends, retained_earnings)
    per_share_growth_rate = calculate_per_share_growth_rate(data)
    estimated_earnings = calculate_estimated_earnings(data, per_share_growth_rate)
    initial_rate_of_return = calculate_initial_rate_of_return(estimated_earnings)

    {
      total_dividends: dividends,
      total_retained_earnings: retained_earnings,
      dividend_percentage: dividend_percentage.round(2),
      retained_earnings_percentage: (100 - dividend_percentage.round(2)),
      initial_rate_of_return: {
        current_price: current_price,
        estimated_earnings: estimated_earnings.round(2),
        initial_rate_of_return: initial_rate_of_return.round(2),
        value_relative_to_government_bonds: calculate_value_relative_to_government_bonds(initial_rate_of_return).round(2)
      },
      pe_ratio: {
        average_high_pe_ratio: calculate_average(data, :high_pe_ratio),
        average_low_pe_ratio: calculate_average(data, :low_pe_ratio),
        highest_pe_ratio: find_highest_value(data, :high_pe_ratio),
        lowest_pe_ratio: find_lowest_value(data, :low_pe_ratio)
      },
      growth: {
        per_share_growth_rate: per_share_growth_rate
      }
    }
  end

  def sum_data(data, key)
    data.map do |year, year_data|
      year_data[key]
    end.reduce(:+)
  end

  def calculate_average(data, key)
    total = sum_data(data, key)
    (total / data.keys.size).round(1)
  end

  def find_highest_value(data, key)
    data.map do |year, year_data|
      year_data[key]
    end.max
  end

  def find_lowest_value(data, key)
    data.map do |year, year_data|
      year_data[key]
    end.min
  end

  def calculate_dividend_percentage(dividends, retained_earnings)
    (dividends / (dividends + retained_earnings) * 100)
  end

  def calculate_per_share_growth_rate(data)
    return '0.00'.to_d if single_year_report?

    present_value = data[@first_year][:earnings]
    future_value = data[@last_year][:earnings]

    CalculateRateOfReturn.new(present_value, future_value, @last_year - @first_year).call
  end

  def calculate_estimated_earnings(data, per_share_growth_rate)
    earnings = data[@last_year][:earnings]

    ((earnings * per_share_growth_rate / 100) + earnings)
  end

  def calculate_initial_rate_of_return(estimated_earnings)
    (estimated_earnings / current_price * 100)
  end

  def calculate_value_relative_to_government_bonds(initial_rate_of_return)
    (initial_rate_of_return / government_bond_interest_rate)
  end

  def single_year_report?
    @first_year == @last_year
  end
end
