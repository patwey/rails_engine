class Api::V1::MerchantsFavoriteCustomerController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.find(params[:id]).favorite_customer
  end
end
