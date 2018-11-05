class UdpdateCreatedAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :created_at , :registered_at
  end
end
