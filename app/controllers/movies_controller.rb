class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json( only: [:id, :title, :release_date])
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    if @movie.nil?
      render json: { errors: {
        title: ["Movie #{params[:id]} not found"]
      }
    },
      status: :not_found
    else
      render json: @movie.as_json(except: [:created_at, :updated_at])

    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id }, status:  :ok
    else
      render json: {
        errors: {
          title: ["Could not create '#{movie_params[:title]}' Movie"]
        },
        message: movie.errors.messages
      }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :inventory, :release_date)
  end

end
