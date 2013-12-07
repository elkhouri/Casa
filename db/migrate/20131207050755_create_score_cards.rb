class CreateScoreCards < ActiveRecord::Migration
  def change
    create_table :score_cards do |t|
      t.integer :engagement
      t.integer :preparedness
      t.integer :attention
      t.integer :overall
      t.string :note
      t.references :student, index: true
      t.references :volunteer, index: true

      t.timestamps
    end
  end
end
