class RentalsController < ApplicationController
  before_action :find_movie
  before_action :find_customer
  before_action :find_rental, only: [:check_in]

  def check_out
    if @movie.available?
      rental = Rental.new(rental_params)
      rental.due_date = Date.today + 7
      rental.checkout_date = Date.today
      if rental.save
        render json: { id: rental.id }, status: :ok
      else
        render json: { errors:
          {
          title: ["ERROR: #{@movie.title} was not checked_out"]
          }
        }, status: :bad_request
      end
    else
    render json: { errors: {
      title: ["Movie #{@movie.title} not available"]
        }
      },  status: :bad_request
    end
  end




  def check_in
    if @rental.nil?
      render json:
      { errors:
        {
          title: ["Could not find rental"]
        }
      },
    status: :bad_request
    else
      @rental.checkin_date = Date.today
      @rental.save
      render json: {
        message: "#{@rental.movie.title} checked in",
        id: @rental.id
    },
    status: :ok
    end
  end

  def overdue
    rentals = Rental.where("checkin_date = ? AND due_date < ?", Date.new(0), Date.today)
    if rental_params[:sort]
      if ['title', 'name', 'checkout_date','due_date'].include?(rental_params[:sort])
        rentals = rentals.sort_by{ |rental| rental[rental_params[:sort]] }
        render json: rentals.as_json( except: [:updated_at])

      else
        render json: {
          errors: {
          title: ["Overdue rentals cannot be sorted by #{rental_params[:sort]}"]
        }
      },
      status: :bad_request
      end
    else
    render json: rentals.as_json( except: [:updated_at])
    end
  end



private

  def rental_params
    params.permit(:customer_id, :movie_id, :sort, :n, :p)
  end

  def find_movie
    @movie = Movie.find_by(id: rental_params[:movie_id])
  end

  def find_customer
    @customer = Customer.find_by(id: rental_params[:customer_id])
  end

  def find_rental
    @rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id], checkin_date: Date.new(0))
  end




end
