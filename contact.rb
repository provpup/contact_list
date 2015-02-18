require_relative 'contact_database'

class Contact

  attr_accessor :first_name, :last_name, :email
  attr_reader :id#, :phone_numbers

  def initialize(first_name, last_name, email, id = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
  end
 
  def to_s
    phone_num = ''
    #phone_num = ' (phone numbers hidden)' if !@phone_numbers.empty?
    "#{first_name} #{last_name} (#{email})#{phone_num}"
  end

  def save
    if id
      self.class.update(self)
    else
      id = self.class.create(first_name, last_name, email)
    end
  end

  def destroy
    ContactDatabase.remove_row_with_id(id)
  end
 
  ## Class Methods
  class << self
    #def create(name, email, phone_numbers)
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
      #phone_number_hash = parse_phone_numbers(row[2])
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
    
    # Return all contacts whose values contain the given string
    def find(value)
      # Any standard errors raised by ContactDatabase will flow upwards
      rows_hash = ContactDatabase.search_for_row_with(email: value)
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
        #phone_number_hash = parse_phone_numbers(row[2])
        contact = Contact.new(row[:firstname.to_s], row[:lastname.to_s], row[:email.to_s], row[:id.to_s])
        #contact = Contact.new(row[0], row[1], phone_number_hash, rows_hash[row])
        contacts << contact
      end
      contacts
    end
    # This method takes in a string value that was serialized hash
    # the string should represent an array of arrays (each subarray
    # is a key-value pair in the hash)
    # For example:
    # "[]" should yield an empty hash
    # "[[:mobile, ""604-123-4567""], [:office, ""604-765-4321""]]" should
    #   yield a hash object with two key-value pairs
    def parse_phone_numbers(phone_num_string)
      phone_numbers = Hash.new
      # First remove the outer brackets
      phone_num_string = phone_num_string[1, phone_num_string.length - 2]
      # Remove the first opening bracket and the last closing bracket
      phone_num_string = phone_num_string[1, phone_num_string.length - 2] unless phone_num_string.nil?
      phone_num_string = "" if phone_num_string.nil?
      array_key_value_pair_strings = phone_num_string.split('], [')
      array_key_value_pair_strings.each do |string_value|
        key_val_array = string_value.split(', ')
        if key_val_array[0].start_with?(':')
          # If key is a symbol, convert it
          key_val_array[0] = key_val_array[0][1, key_val_array[0].length - 1]
          key_val_array[0] = key_val_array[0].to_sym
        end
        # Remove any quotes from the phone number string
        phone_numbers[key_val_array[0]] = key_val_array[1].gsub('"','')
      end

      phone_numbers
    end
  end
end
