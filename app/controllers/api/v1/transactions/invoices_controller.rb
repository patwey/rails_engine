class Api::V1::Transactions::InvoicesController < ApplicationController
  respond_to :json

  def show
    respond_with Transaction.find(params[:id]).invoice
  end
end
