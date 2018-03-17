# frozen_string_literal: true

class SharePricesController < ApplicationController
  before_action :find_stock, only: [:new, :create]

  def new
    @share_price = @stock.share_prices.new
  end

  def create
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end
end
