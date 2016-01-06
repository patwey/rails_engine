class Api::V1::ItemsMostItemsController < ApplicationController
  respond_to :json

  def index
    ii_by_qty = InvoiceItem.all_items_by_quantity
    respond_with Item.most_items(params[:quantity].to_i, ii_by_qty)
  end
end
