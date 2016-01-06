class Api::V1::Customers::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.find(params[:id]).invoices
  end
end
