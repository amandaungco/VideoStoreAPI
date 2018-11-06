class RentalsController < ApplicationController
  before_action :find_movie
  before_action :find_customer
# find customer before check in
# find movie before check in
  def check_out
    if @movie.available?
      rental = Rental.new(rental_params)
      rental.due_date = Date.today + 7
      rental.checkout_date = Date.today
      rental.save
      @movie.check_out_movie
      @movie.save
      #binding.pry
    else
      render json: { errors: {
        title: ["Movie #{@movie.title} not available"]
      }
    },
      status: :bad_request
    end
  end




  def check_in
    #find rental isntance for customer_id and movie_id
    #update rental instance
    #check_in: today
    #call inventory method for check in
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def find_movie
    @movie = Movie.find_by(id: rental_params[:movie_id])
  end

  def find_customer
    @customer = Customer.find_by(id: params[:id])
  end




end
