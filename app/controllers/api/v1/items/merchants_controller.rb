class Api::V1::Items::MerchantsController < ApplicationController
  respond_to :json

  def show
    respond_with Item.find(params[:id]).merchant
  end
end
