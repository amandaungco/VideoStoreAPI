class CustomersController < ApplicationController
  @@fields = [:id, :name, :register, :postal_code, :phone, :registered_at]
  @@method = :movies_checked_out_count
  @@sort_params = ['name', 'registered_at', 'postal_code']

  def index
    customers = Customer.all
    sort(customers, customer_params[:sort], @@sort_params, @@fields, method: @@method)
end

private

def customer_params
  params.permit(:sort, :n, :p)
end

end
