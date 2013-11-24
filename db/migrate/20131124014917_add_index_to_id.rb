class AddIndexToId < ActiveRecord::Migration
  def change
    add_index :users, :ID_num, unique: true
  end
end
