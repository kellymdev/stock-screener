# frozen_string_literal: true

class DividendsController < ApplicationController
  before_action :find_stock, only: [:new, :create]

  def new
    @dividend = @stock.dividends.new
  end

  def create
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end
end
