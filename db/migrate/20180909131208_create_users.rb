class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.string :phone_number
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
