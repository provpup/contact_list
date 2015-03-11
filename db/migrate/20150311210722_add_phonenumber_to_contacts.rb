class AddPhonenumberToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phonenumber, :string
  end
end
