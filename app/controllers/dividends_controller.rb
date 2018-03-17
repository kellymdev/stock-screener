# frozen_string_literal: true

class DividendsController < ApplicationController
  before_action :find_stock, only: [:new, :create]
  before_action :find_dividend, only: [:edit, :update]

  def new
    @dividend = @stock.dividends.new
  end

  def create
    @dividend = @stock.dividends.new(dividend_params)

    if @dividend.save
      redirect_to @stock
    else
      render :new
    end
  end

  def edit; end

  def update
    if @dividend.update(dividend_params)
      redirect_to @dividend.stock
    else
      render :edit
    end
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def find_dividend
    @dividend = Dividend.find(params[:id])
  end

  def dividend_params
    params.require(:dividend).permit(:year_id, :value)
  end
end
