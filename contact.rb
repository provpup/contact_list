class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: assign local variables to instance variables
  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
    end
 
    def find(index)
      # TODO: Will find and return contact by index
    end
 
    def all
      # TODO: Return the list of contacts, as is
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end

