class CreateTutorages < ActiveRecord::Migration
  def change
    create_table :tutorages do |t|
      t.belongs_to :volunteer
      t.belongs_to :student

      t.timestamps
    end
  end

end
