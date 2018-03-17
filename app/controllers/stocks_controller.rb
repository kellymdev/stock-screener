# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :find_stock_exchange, only: [:new, :create]
  before_action :find_stock, only: [:show, :edit, :update]

  def new
    @stock = @stock_exchange.stocks.new
  end

  def create
    @stock = @stock_exchange.stocks.new(stock_params)

    if @stock.save
      redirect_to @stock
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @stock.update(stock_params)
      redirect_to @stock
    else
      render :edit
    end
  end

  private

  def find_stock_exchange
    @stock_exchange = StockExchange.find(params[:stock_exchange_id])
  end

  def find_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:company_name, :ticker_symbol)
  end
end
