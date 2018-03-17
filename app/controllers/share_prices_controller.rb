# frozen_string_literal: true

class SharePricesController < ApplicationController
  before_action :find_stock

  def create
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end
end
