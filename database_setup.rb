require 'pg'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: '##############',
  username: '##############',
  password: '##############',
  host:     '##############',
  port: 5432,
  min_messages: 'error'
)
puts "CONNECTED"


ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.table_exists?(:contacts)
    puts "Setting up Database (creating tables) ..."

    create_table :contacts do |table|
      table.column :firstname, :string
      table.column :lastname, :string
      table.column :email, :string
      table.timestamps
    end

    Contact.create(firstname: 'Alan', lastname: 'Hodges', email: 'alan.hodges@abcdef.com')
    Contact.create(firstname: 'Dylan', lastname: 'May', email: 'dylan.may@abcdef.com')
    Contact.create(firstname: 'Jennifer', lastname: 'Churchill', email: 'jennifer.churchill@abcdef.com')
    Contact.create(firstname: 'Warren', lastname: 'Pullman', email: 'warren.pullman@abcdef.com')
    Contact.create(firstname: 'Colin', lastname: 'Jackson', email: 'colin.jackson@abcdef.com')
    Contact.create(firstname: 'Colin', lastname: 'Chapman', email: 'colin.chapman@abcdef.com')
    Contact.create(firstname: 'Michael', lastname: 'Clarkson', email: 'michael.clarkson@abcdef.com')
    Contact.create(firstname: 'Lily', lastname: 'Slater', email: 'lily.slater@abcdef.com')
    Contact.create(firstname: 'Sam', lastname: 'Hudson', email: 'sam.hudson@abcdef.com')
    Contact.create(firstname: 'Sonia', lastname: 'Harris', email: 'sonia.harris@abcdef.com')
    Contact.create(firstname: 'Emma', lastname: 'Paterson', email: 'emma.paterson@abcdef.com')
    Contact.create(firstname: 'Sue', lastname: 'Jackson', email: 'sue.jackson@abcdef.com')
    Contact.create(firstname: 'Connor', lastname: 'Hughes', email: 'connor.hughes@abcdef.com')
    Contact.create(firstname: 'Theresa', lastname: 'North', email: 'theresa.north@abcdef.com')
    Contact.create(firstname: 'Stephen', lastname: 'Gibson', email: 'stephen.gibson@abcdef.com')
    Contact.create(firstname: 'Zoe', lastname: 'Harris', email: 'zoe.harris@abcdef.com')
    Contact.create(firstname: 'Steven', lastname: 'Short', email: 'steven.short@abcdef.com')
    Contact.create(firstname: 'Dorothy', lastname: 'Walsh', email: 'dorothy.walsh@abcdef.com')
    Contact.create(firstname: 'Boris', lastname: 'Bell', email: 'boris.bell@abcdef.com')
    Contact.create(firstname: 'Victor', lastname: 'Mitchell', email: 'victor.mitchell@abcdef.com')
  end
end
