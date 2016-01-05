class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.where(item_params)
  end

  def show
    if random?
      respond_with Item.random
    else
      respond_with Item.find_by(item_params)
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
