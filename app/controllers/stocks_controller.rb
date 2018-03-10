# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :find_stock_exchange

  def new
    @stock = @stock_exchange.stocks.new
  end

  def create
    @stock = @stock_exchange.stocks.new(stock_params)

    if @stock.save
      redirect_to @stock_exchange
    else
      render :new
    end
  end

  private

  def find_stock_exchange
    @stock_exchange = StockExchange.find(params[:stock_exchange_id])
  end

  def stock_params
    params.require(:stock).permit(:company_name, :ticker_symbol)
  end
end
