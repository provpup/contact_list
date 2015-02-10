require_relative 'contact_database'

class Contact

  attr_reader :name, :email, :id, :phone_numbers

  def initialize(name, email, phone_numbers = {}, id = nil)
    @name = name
    @email = email
    @phone_numbers = phone_numbers
    @id = id
  end
 
  def to_s
    phone_num = ''
    phone_num = ' (phone numbers hidden)' if !@phone_numbers.empty?
    "#{name} (#{email})#{phone_num}"
  end
 
  ## Class Methods
  class << self
    def create(name, email, phone_numbers)
      database = ContactDatabase.new
      # Any standard errors raised by ContactDatabase will flow upwards
      id = database.add_row(name, email, phone_numbers)

      contact = Contact.new(name, email, phone_numbers, id)
    end
 
    def get(index)
      database = ContactDatabase.new
      row = database.find_row_by_id(index)
      phone_number_hash = parse_phone_numbers(row[2])
      contact = Contact.new(row[0], row[1], phone_number_hash, index)
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
        phone_number_hash = parse_phone_numbers(row[2])
        contact = Contact.new(row[0], row[1], phone_number_hash, rows_hash[row])
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
        phone_number_hash = parse_phone_numbers(row[2])
        contact = Contact.new(row[0], row[1], phone_number_hash, rows_hash[row])
        contacts.push(contact)
      end

      contacts
    end

    def email_already_exists?(email)
      # Find contacts that contain the email string
      contacts_containing_email = find(email)

      # Out of those, see if there are any with an exact match
      contacts_containing_email.any? do |contact|
        contact.email == email
      end
    end

    private
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
