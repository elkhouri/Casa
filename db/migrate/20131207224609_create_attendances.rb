class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user, index: true
      t.string :work
      t.datetime :dropoff_time
      t.references :dropoff, index: true
      t.datetime :pickup_time
      t.references :pickup, index: true
      t.string :override

      t.timestamps
    end
  end
end
