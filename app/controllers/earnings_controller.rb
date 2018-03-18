# frozen_string_literal: true

class EarningsController < ApplicationController
  before_action :find_stock, only: [:new, :create]

  def new
    @earning = @stock.earnings.new
  end

  def create
    @earning = @stock.earnings.new(earning_params)

    if @earning.save
      redirect_to @stock
    else
      render :new
    end
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def earning_params
    params.require(:earning).permit(:year_id, :value)
  end
end
