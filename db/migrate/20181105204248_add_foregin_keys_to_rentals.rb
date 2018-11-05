class AddForeginKeysToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true
    remove_column :movies, :customer_id
    remove_column :customers, :movie_id
    rename_column :rentals, :created_at, :checkout_date
  end
end
