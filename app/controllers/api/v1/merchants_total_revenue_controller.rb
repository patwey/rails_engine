class Api::V1::MerchantsTotalRevenueController < ApplicationController
  respond_to :json

  def show
    merchant = Merchant.find(params[:id])
    if params[:date]
      respond_with merchant.total_revenue_on(params[:date])
    else
      respond_with merchant.total_revenue
    end
  end
end
