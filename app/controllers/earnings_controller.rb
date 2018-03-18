# frozen_string_literal: true

class EarningsController < ApplicationController
  before_action :find_stock, only: [:new, :create]

  def new
    @earning = @stock.earnings.new
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end
end
