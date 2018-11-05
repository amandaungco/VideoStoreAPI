class UndoLastMigration < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :rental_id
    remove_column :customers, :rental_id
  end
end
