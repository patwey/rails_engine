class Api::V1::MerchantsMostRevenueController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.by_most_revenue(params[:quantity].to_i)
  end
end
