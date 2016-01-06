class Api::V1::ItemsMostRevenueController < ApplicationController
  respond_to :json

  def index
    ii_by_revenue = InvoiceItem.all_items_by_revenue
    respond_with Item.most_revenue(params[:quantity].to_i, ii_by_revenue)
  end
end
