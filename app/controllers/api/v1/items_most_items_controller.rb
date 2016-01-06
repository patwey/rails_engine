class Api::V1::ItemsMostItemsController < ApplicationController
  respond_to :json

  def index
    invoice_items = InvoiceItem.all_items_by_quantity
    respond_with Item.most_items(params[:quantity].to_i, invoice_items)
  end
end
