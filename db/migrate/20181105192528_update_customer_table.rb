class UpdateCustomerTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :registered_at, :created_at 
    rename_column :customers, :created_at , :registered_at

  end
end
