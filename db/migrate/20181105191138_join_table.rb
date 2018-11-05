class JoinTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :customer, foreign_key: true
    add_reference :customers, :movie, foreign_key: true
  end
end
