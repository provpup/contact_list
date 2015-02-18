require 'pg'
require_relative 'database_credentials'

class ContactDatabaseError < StandardError
end

class ContactDatabase

  CONTACT_TABLE_NAME = 'contacts'

  class << self

  # This will return a hash with the index as the key and
  # the contact data array as the value
  def all_rows
    connection = establish_connection
    rows = connection.exec("SELECT * FROM #{CONTACT_TABLE_NAME} ORDER BY id;")
    #rows
  rescue PG::Error => error
    raise ContactDatabaseError, error.message
  end

  def find_row_by_id(row_id)
    connection = self.establish_connection
    row = connection.exec_params("SELECT * FROM #{CONTACT_TABLE_NAME} WHERE id = $1 ORDER BY id;", [row_id])
  rescue PG::Error => error
    raise ContactDatabaseError, error.message
  end

  def search_for_row_with(values_hash)
    connection = self.establish_connection
    hash_key = values_hash.keys.first
    rows = connection.exec_params("SELECT * FROM #{CONTACT_TABLE_NAME} WHERE #{hash_key} = $1 ORDER BY id;", [values_hash[hash_key]])
  rescue PG::Error => error
    raise ContactDatabaseError, error.message
  end

  def update_row_by_id(row_id, values_hash)
    connection = self.establish_connection
    result = connection.exec_params("UPDATE #{CONTACT_TABLE_NAME} SET firstname=$1, lastname=$2, email=$3 WHERE id = $4",
                                    [values_hash[:first_name], values_hash[:last_name], values_hash[:email], row_id])
  rescue PG::Error => error
    raise ContactDatabaseError, error.message
  end

  def add_row(values_hash)
    connection = self.establish_connection
    id_column_name = 'id'
    result = connection.exec_params("INSERT INTO #{CONTACT_TABLE_NAME} (firstname, lastname, email) VALUES ($1, $2, $3) returning #{id_column_name};",
                                    [values_hash[:first_name], values_hash[:last_name], values_hash[:email]])
    result[0][id_column_name].to_i
  rescue PG::Error => error
    raise(ContactDatabaseError, error.message)
  end

  def remove_row_with_id(row_id)
    connection = self.establish_connection
    result = connection.exec_params("DELETE FROM #{CONTACT_TABLE_NAME} WHERE id = $1", [row_id])
  rescue PG::Error => error
    raise ContactDatabaseError, error.message
  end

  def establish_connection
    unless @connection
      @connection = PG.connect(DatabaseCredentials.credentials)
    end
    @connection
  end
end

end
