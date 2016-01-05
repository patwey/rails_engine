class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.where(transaction_params)
  end

  def show
    respond_with Transaction.find_by(transaction_params)
  end

  def random
    respond_with Transaction.random
  end

  private

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
