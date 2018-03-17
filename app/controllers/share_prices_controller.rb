# frozen_string_literal: true

class SharePricesController < ApplicationController
  before_action :find_stock, only: [:new, :create]

  def new
    @share_price = @stock.share_prices.new
  end

  def create
    @share_price = @stock.share_prices.new(share_price_params)

    if @share_price.save
      redirect_to @stock
    else
      render :new
    end
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def share_price_params
    params.require(:share_price).permit(:year_id, :high_value, :low_value)
  end
end
