# frozen_string_literal: true

class SharePricesController < ApplicationController
  before_action :find_stock, only: [:new, :create]
  before_action :find_share_price, only: [:edit, :update, :destroy]

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

  def edit; end

  def update
    if @share_price.update(share_price_params)
      redirect_to @share_price.stock
    else
      render :edit
    end
  end

  def destroy
    @stock = @share_price.stock
    @share_price.destroy!

    redirect_to @stock
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def find_share_price
    @share_price = SharePrice.find(params[:id])
  end

  def share_price_params
    params.require(:share_price).permit(:year_id, :high_value, :low_value)
  end
end
