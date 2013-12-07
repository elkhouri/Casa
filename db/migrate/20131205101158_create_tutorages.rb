class CreateTutorages < ActiveRecord::Migration
  def change
    create_table :tutorages do |t|
      t.belongs_to :volunteer, index: true
      t.belongs_to :student, index: true

      t.timestamps
    end
  end

end
