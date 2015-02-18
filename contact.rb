require_relative 'contact_database'

class Contact

  attr_accessor :first_name, :last_name, :email, :phone_numbers
  attr_reader :id

  def initialize(first_name, last_name, email, id = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
    @phone_numbers = []
  end
 
  def to_s
    "#{first_name} #{last_name} (#{email})"
  end

  def save
    if id
      self.class.update(self)
    else
      new_contact = self.class.create(first_name, last_name, email)
      id = new_contact.id
    end
  end

  def destroy
    ContactDatabase.remove_row_with_id(id) if id
  end
 
  ## Class Methods
  class << self
    def create(first_name, last_name, email)
      # Any standard errors raised by ContactDatabase will flow upwards
      id = ContactDatabase.add_row(first_name: first_name, last_name: last_name, email: email)

      contact = Contact.new(first_name, last_name, email, id)
    end

    def update(contact)
      ContactDatabase.update_row_by_id(contact.id, first_name: contact.first_name,
                                                   last_name: contact.last_name,
                                                   email: contact.email)
    end
 
    def get(index)
      rows_hash = ContactDatabase.find_row_by_id(index)
      contact = to_contacts(rows_hash).first
    rescue ContactDatabaseError => error
      raise(ArgumentError, "Invalid index\n#{error.message}")
    end
 
    # Return all Contact objects
    def all
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = ContactDatabase.all_rows
      contacts = to_contacts(rows_hash)
    end

    def find_all_by_lastname(last_name)
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = ContactDatabase.search_for_row_with(lastname: last_name)
      contacts = to_contacts(rows_hash)
    end

    def find_all_by_firstname(first_name)
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = ContactDatabase.search_for_row_with(firstname: first_name)
      contacts = to_contacts(rows_hash)
    end

    def find_by_email(email)
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = ContactDatabase.search_for_row_with(email: email)
      contacts = to_contacts(rows_hash)
      if contacts.size > 1
        raise "More than one contact has the same email address: #{email}"
      end

      contacts.first
    end

    def email_already_exists?(email)
      # Find contacts that contain the email string
      contacts_containing_email = find_by_email(email)

      !contacts_containing_email.nil?
    end

    private
    def to_contacts(rows_hash)
      contacts = []
      rows_hash.each do |row|
        contact = Contact.new(row[:firstname.to_s], row[:lastname.to_s], row[:email.to_s], row[:id.to_s])
        contacts << contact
      end
      contacts
    end
  end
end
