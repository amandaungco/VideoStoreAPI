class CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customer_params[:sort]
      if ['name', 'registered_at', 'postal_code'].include?(customer_params[:sort])
        customers = customers.sort_by{ |customer| customer[customer_params[:sort]] }
        render json: customers.as_json( only: [:id, :name, :register, :postal_code, :phone, :registered_at], methods: :movies_checked_out_count)

      else
        render json: { errors: {
          title: ["Customers cannot be sorted by #{customer_params[:sort]}"]
        }
      },
      status: :not_found
    end
  else

    render json: customers.as_json( only: [:id, :name, :register, :postal_code, :phone, :registered_at], methods: :movies_checked_out_count)
  end
end

private

def customer_params
  params.permit(:sort, :n, :p)
end

end
