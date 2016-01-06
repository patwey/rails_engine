class Api::V1::RandomTransactionsController < ApplicationController
  respond_to :json

  def show
    respond_with Transaction.order("RANDOM()").first
  end
end
