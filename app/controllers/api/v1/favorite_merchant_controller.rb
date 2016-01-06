class Api::V1::FavoriteMerchantController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.favorite_merchant(params[:id])
  end
end
