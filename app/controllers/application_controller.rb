class ApplicationController < ActionController::API

  def sort(list, params, sort_params, fields, method: nil)
    # if :method

      if params

        if sort_params.include?(params)
          #list = list.order(params)
          list = list.sort_by{ |unit| unit.send(params) }
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
