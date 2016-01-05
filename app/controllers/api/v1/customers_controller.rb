class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.where(customer_params)
  end

  def show
    if random?
      respond_with Customer.random
    else
      respond_with Customer.find_by(customer_params)
    end
  end

  private

  def customer_params
    params.permit(:id, :name)
  end
end
