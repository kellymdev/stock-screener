# frozen_string_literal: true

class StockExchangesController < ApplicationController
  def index
    @stock_exchanges = StockExchange.all.order(:name)
  end
end
