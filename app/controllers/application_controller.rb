class ApplicationController < ActionController::API

  def sort(list, params, sort_params, fields, method: nil)
      if params
        if sort_params.include?(params)
          if params == 'title' || params == 'name'
            if params == 'title'
              list = list.joins(:movie).order("movies.title")
            else params == "name"
              list = list.joins(:customer).order("customers.name")
            end
          end

          list = list.order(params)
          render json: list.as_json( only: fields , methods: method)

        else
          render json: { errors: {
            title: ["#{list.first.class}s cannot be sorted by #{params}"]
          }
        },
        status: :bad_request
      end
    else
      render json: list.as_json( only: fields, methods: method)
    end
    # else
  end
end
