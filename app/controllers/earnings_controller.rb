# frozen_string_literal: true

class EarningsController < ApplicationController
  before_action :find_stock, only: [:new, :create]
  before_action :find_earning, only: [:edit, :update, :destroy]

  def new
    @earning = @stock.earnings.new
  end

  def create
    @earning = @stock.earnings.new(earning_params)

    if @earning.save
      redirect_to @stock, notice: 'Earning successfully added'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @earning.update(earning_params)
      redirect_to @earning.stock, notice: 'Earning successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @stock = @earning.stock
    @earning.destroy!

    redirect_to @stock
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def find_earning
    @earning = Earning.find(params[:id])
  end

  def earning_params
    params.require(:earning).permit(:year_id, :value)
  end
end
