class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json( only: [:id, :name, :register, :postal_code, :phone, :registered_at], methods: :movies_checked_out_count)
  end

end
