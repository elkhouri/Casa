class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :grade, :integer
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :interest, :string
    add_column :users, :specialization, :string
  end
end
