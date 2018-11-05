class AddAssociationForRentalsInMoviesCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :rental, foreign_key: true
    add_reference :customers, :rental, foreign_key: true
  end
end
