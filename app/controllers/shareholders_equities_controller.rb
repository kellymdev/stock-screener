# frozen_string_literal: true

class ShareholdersEquitiesController < ApplicationController
  before_action :find_stock, only: [:new, :create]
  before_action :find_shareholders_equity, only: [:edit, :update, :destroy]

  def new
    @shareholders_equity = @stock.shareholders_equities.new
  end

  def create
    @shareholders_equity = @stock.shareholders_equities.new(shareholders_equity_params)

    if @shareholders_equity.save
      redirect_to @stock, notice: 'Shareholders equity successfully added'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @shareholders_equity.update(shareholders_equity_params)
      redirect_to @shareholders_equity.stock, notice: 'Shareholders equity successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @stock = @shareholders_equity.stock
    @shareholders_equity.destroy!

    redirect_to @stock
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def find_shareholders_equity
    @shareholders_equity = ShareholdersEquity.find(params[:id])
  end

  def shareholders_equity_params
    params.require(:shareholders_equity).permit(:year_id, :value)
  end
end
