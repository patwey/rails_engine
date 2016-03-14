class Api::V1::RandomInvoiceItemsController < ApplicationController
  respond_to :json

  def show
    respond_with InvoiceItem.order("RANDOM()").first
  end
end
