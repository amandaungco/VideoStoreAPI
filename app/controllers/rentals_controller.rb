class RentalsController < ApplicationController
  before_action :find_movie
  before_action :find_customer
  before_action :find_rental, only: [:check_in]

  def check_out
    if @movie.available?
      rental = Rental.new(rental_params)
      rental.due_date = Date.today + 7
      rental.checkout_date = Date.today
      rental.save
      @movie.check_out_movie
      render json: { id: rental.id }, status: :ok 
    else
      render json: { errors: {
        title: ["Movie #{@movie.title} not available"]
      }
    },
      status: :bad_request
    end
  end




  def check_in
    if @rental.nil?
      render json: { errors: {
        title: ["Could not find rental"]
      }
    },
      status: :bad_request
    else
      @rental.checkin_date = Date.today
      @rental.save
      @rental.movie.check_in_movie
    end
  end




  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

  def find_movie
    @movie = Movie.find_by(id: rental_params[:movie_id])
  end

  def find_customer
    @customer = Customer.find_by(id: rental_params[:customer_id])
  end

  def find_rental
    @rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id], checkin_date: nil)
  end




end
