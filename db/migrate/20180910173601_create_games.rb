class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :pitch
      t.datetime :date
      t.integer :players_quantity
      t.integer :time_length
      t.references :user

      t.timestamps
    end
  end
end
