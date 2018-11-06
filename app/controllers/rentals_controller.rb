class RentalsController < ApplicationController
# find customer before check in
# find movie before check in
  def check_out
    #check inventory of movie_id
    #call inventory method for checkout
      #if positive
        #create new instance of rental
        #checkout_date: Today
        #due_date: Today + 7
        #check_in: nil
      #else
        #sorry we're out of stock
        #bad_request
      #end
  end

  def check_in
    #find rental isntance for customer_id and movie_id
    #update rental instance
    #check_in: today
    #call inventory method for check in
  end
end
