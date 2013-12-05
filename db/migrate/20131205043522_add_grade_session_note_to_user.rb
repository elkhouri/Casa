class AddGradeSessionNoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :session, :string
    add_column :users, :note, :string
  end
end
