class Api::V1::RandomItemsController < ApplicationController
  respond_to :json

  def show
    respond_with Item.order("RANDOM()").first
  end
end
