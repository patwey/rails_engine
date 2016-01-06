class Api::V1::Customers::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.find(params[:id]).transactions
  end
end
