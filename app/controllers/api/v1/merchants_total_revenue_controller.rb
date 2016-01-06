class Api::V1::MerchantsTotalRevenueController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.find(params[:id]).total_revenue
  end
end
