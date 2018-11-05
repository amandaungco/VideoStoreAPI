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
      render json: {ok: true, movie: @movie.as_json(except: [:created_at, :updated_at])
      }
    end
  end
end
