# Stock Exchanges
# asx = StockExchange.create!(name: 'ASX')
# nzx = StockExchange.create!(name: 'NZX')
# nyse = StockExchange.create!(name: 'NYSE')

# Years
years = 2007..2017

years.each do |year|
  Year.create!(year_number: year)
end
