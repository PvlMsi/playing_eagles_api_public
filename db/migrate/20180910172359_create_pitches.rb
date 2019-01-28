class CreatePitches < ActiveRecord::Migration[5.2]
  def change
    create_table :pitches do |t|
      t.string :city
      t.string :address
      t.integer :opening_hour
      t.integer :closing_hour

      t.timestamps
    end
  end
end
