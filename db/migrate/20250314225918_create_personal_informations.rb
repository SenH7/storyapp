class CreatePersonalInformations < ActiveRecord::Migration[7.2]
  def change
    create_table :personal_informations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :username
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
