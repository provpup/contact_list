class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :numbertype
      t.string :phonenumber
      t.references :contact, index: true

      t.timestamps null: false
    end
  end
end
