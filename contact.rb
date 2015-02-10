require_relative 'contact_database'

class Contact
 
  attr_reader :name, :email, :id

  def initialize(name, email, id = nil)
    @name = name
    @email = email
    @id = id
  end
 
  def to_s
    "#{name} (#{email})"
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      database = ContactDatabase.new
      # Any standard errors raised by ContactDatabase will flow upwards
      id = database.add_row(name, email)

      contact = Contact.new(name, email, id)
    end
 
    def get(index)
      database = ContactDatabase.new
      row = database.find_row_by_id(index)
      found_contact = Contact.new(row[0], row[1], index)
    rescue ContactDatabaseError => error
      raise(ArgumentError, "Invalid index\n#{error.message}")
    end
 
    # Return all Contact objects
    def all
      database = ContactDatabase.new
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = database.get_all_rows
      contacts = []
      rows_hash.keys.each do |row|
        contact = Contact.new(row[0], row[1], rows_hash[row])
        contacts.push(contact)
      end

      contacts
    end
    
    # Return all contacts whose values contain the given string
    def find(value)
      database = ContactDatabase.new
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = database.search_for_row_with(value)
      contacts = []
      rows_hash.keys.each do |row|
        contact = Contact.new(row[0], row[1], rows_hash[row])
        contacts.push(contact)
      end

      contacts
    end

    def email_already_exists?(email)
      # Find contacts that contain the email
      contacts_containing_email = find(email)

      # Out of those, select any with an exact match
      contacts_with_exact_email = contacts_containing_email.select do |contact|
        contact.email == email
      end

      !contacts_with_exact_email.empty?
    end
    
  end
 
end

