class CreateScheduledEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_events do |t|
      t.references :pitch
      t.references :user
      t.date :first_date
      t.date :last_date
      t.time :starting_hour
      t.time :finishing_hour
      t.integer :interval
      t.integer :interval_type
      t.string :description
      t.boolean :canceled, default: false

      t.timestamps
    end
  end
end
