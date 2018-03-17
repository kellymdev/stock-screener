# frozen_string_literal: true

class DividendsController < ApplicationController
  before_action :find_stock, only: [:new, :create]

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

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def dividend_params
    params.require(:dividend).permit(:year_id, :value)
  end
end
