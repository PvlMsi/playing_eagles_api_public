class CreateOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :opinions do |t|
      t.references :player
      t.references :issuing_user
      t.text :description
      t.boolean :anonymous, default: false
      t.integer :fair_play_rate
      t.integer :would_recommend_rate

      t.timestamps
    end
  end
end
