require 'csv'

class ContactDatabaseError < StandardError
end

class ContactDatabase

  def initialize
    @csv_file = 'contacts.csv'
  end

  # This will return a hash with the index as the key and
  # the contact data array as the value
  def get_all_rows
    contacts = open_database_for_reading
    contacts_indices = Array(1..contacts.length)

    contacts_hash = contacts.zip(contacts_indices).to_h
  end

  def find_row_by_id(row_id)
    contacts = get_all_rows
    if contacts.empty?
      raise(ContactDatabaseError, 'Contact database is empty')
    end
    if row_id <= 0 || row_id > contacts.length
      raise(ContactDatabaseError, "Invalid row id, valid values must be between 1 and #{contacts.length} inclusive")
    end
    contacts.keys[row_id - 1]
  end

  def search_for_row_with(string_value)
    contacts_hash = get_all_rows
    # The contacts data arrays are keys in the hash, so we see if any
    # of them have string_value contained in any one of the values
    contacts_array = contacts_hash.keys.select do |contact|
      contact.any? do |data|
        data.include?(string_value)
      end
    end

    # The contacts_array has the matches, but we also need to index data
    # from the contacts_hash
    contacts_hash.select do |contact, contact_index|
      contacts_array.include?(contact)
    end
  end

  def add_row(name, email, phone_numbers)
    begin
      CSV.open(csv_file, 'a') do |csv|
        csv << [name, email, phone_numbers.to_a.inspect]
      end
    rescue StandardError => error
      raise(ContactDatabaseError, error.message)
    end
    get_all_rows.length
  end

  private
  def csv_file
    @csv_file
  end

  def open_database_for_reading
    CSV.read(csv_file, 'r')
  rescue StandardError => error
    raise(ContactDatabaseError, error.message)
  end
end