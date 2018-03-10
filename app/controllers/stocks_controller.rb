# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :find_stock_exchange

  def new
    @stock = @stock_exchange.stocks.new
  end

  private

  def find_stock_exchange
    @stock_exchange = StockExchange.find(params[:stock_exchange_id])
  end
end
