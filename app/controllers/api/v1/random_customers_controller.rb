class Api::V1::RandomCustomersController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.order("RANDOM()").first
  end
end
