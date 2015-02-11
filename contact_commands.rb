require_relative 'contact'
require 'io/console'

# Module that contains methods for displaying contact information
module ContactDisplay

  def display_contact_list(contacts, last_line_description)
    original_number_of_contacts = contacts.length
    page_size = 5

    until contacts.empty?
      page_size.times do
        contact = contacts.shift
        puts "#{contact.id}: #{contact.to_s}" unless contact.nil?
      end
      unless contacts.empty?
        puts "\nPress any key to see more contacts..."
        input = STDIN.getch
      end
    end

    puts "\n---"
    puts "#{original_number_of_contacts} records #{last_line_description}"
  end

  def display_contact_details(contact)
    puts "Index:        #{contact.id}"
    puts "Name:         #{contact.name}"
    puts "E-mail:       #{contact.email}"
    phone_label = 'Phone Number:'
    puts "#{phone_label} <None>" if contact.phone_numbers.empty?
    contact.phone_numbers.each_pair do |number_type, number|
      puts "#{phone_label} (#{number_type.to_s.capitalize}) #{number}"
    end
    puts
  end
end

# Parent class for contact commands
class ContactCommand
  def initialize(*arguments)
    validate_arguments(*arguments)
    @arguments = arguments
  end

  def self.command_description
  end

  def run
    # To be implemented by subclasses
  end
end

# This class runs through the create new contact workflow
class CreateNewContactCommand < ContactCommand

  # This command takes no arguments
  def validate_arguments(*arguments)
    if !arguments.empty?
      raise(ArgumentError, "Invalid arguments: #{arguments.join(' ')}")
    end
  end

  def self.command_description
    '                - Create a new contact'
  end

  # Prompt the user for name, email, and optional phone number information
  def run
    unique_email = false
    until unique_email
      print "\nPlease enter e-mail address for new contact: "
      email = STDIN.gets.chomp.strip
      unique_email = !Contact.email_already_exists?(email)
      puts 'Email already exists in the contact database!' if !unique_email
    end
    print 'Please enter name for new contact: '
    name = STDIN.gets.chomp.strip
    no_tag = 'n'
    phone_number_query = "Do you want to enter phone number for new contact? (y/#{no_tag}): "
    print phone_number_query
    no_more_phone_numbers = no_tag == STDIN.gets.chomp
    phone_numbers = Hash.new
    until no_more_phone_numbers
      print 'Please enter the category of the phone number: '
      phone_type = STDIN.gets.chomp.to_sym
      print 'Please enter the phone number: '
      phone_number = STDIN.gets.chomp
      phone_numbers[phone_type] = phone_number
      print phone_number_query
      no_more_phone_numbers = no_tag == STDIN.gets.chomp
    end
    contact = Contact.create(name, email, phone_numbers)
    puts "\nNew contact #{contact.to_s} added successfully with id: #{contact.id}"
  rescue StandardError => error
    puts "Error encountered creating new contact: #{error.message}"
    puts error.backtrace.inspect
  end
end

# This command lists all contacts
class ListAllContactsCommand < ContactCommand
  include ContactDisplay

  # This command shouldn't take any arguments
  def validate_arguments(*arguments)
    if !arguments.empty?
      raise(ArgumentError, "Invalid arguments: #{arguments.join(' ')}")
    end
  end

  def self.command_description
    '               - List all contacts'
  end

  # List all contacts
  def run
    contacts = Contact.all
    display_contact_list(contacts, 'total')
  end
end

# This command shows a single contact
class ShowContactCommand < ContactCommand
  include ContactDisplay

  # This command only takes in a single number
  def validate_arguments(*arguments)
    if arguments.length != 1
      # This command shouldn't take any arguments
      raise(ArgumentError, "Invalid arguments: #{arguments.join(' ')}")
    end
    @contact_id = arguments.shift
    if @contact_id.nil? || @contact_id.to_i == 0
      # No argument or not a valid number
      raise(ArgumentError, "Invalid argument for showing contact: #{contact_id}")
    end
    @contact_id = @contact_id.to_i
  end

  def self.command_description
    ' <id>          - Show a contact whose id value is <id>'
  end

  # Display the contact details for the provided contact id
  def run
    contact = Contact.get(@contact_id)
    display_contact_details(contact)
  rescue StandardError => error
    puts "Error encountered retrieving contact with id: #{@contact_id}"
    puts error.message
    puts error.backtrace.inspect
  end
end

# This class searches for contacts containing a given string
class FindContactsCommand < ContactCommand
  include ContactDisplay

  # This command accepts only one argument
  def validate_arguments(*arguments)
    if arguments.length != 1
      raise(ArgumentError, "Invalid arguments: #{arguments.join(' ')}")
    end
    @contact_query = arguments.shift
  end

  def self.command_description
    ' <search text> - Find a contact whose name or email contains <search text>'
  end

  # Display all matches for the query
  def run
    contacts = Contact.find(@contact_query)
    display_contact_list(contacts, "found with data \"#{@contact_query}\"\n")
  rescue StandardError => error
    puts "Error encountered retrieving contacts with query data: #{@contact_query}"
    puts error.message
    puts error.backtrace.inspect
  end
end

# This class shows the help message for the program
class ShowHelpCommand < ContactCommand

  # The expected hash has command flag symbols as keys
  # and the command description as the values
  def validate_arguments(*arguments)
    if arguments.length != 1
      # This command shouldn't take any arguments
      raise(ArgumentError, "Invalid arguments: #{arguments.join(' ')}")
    end
    @command_flag_description_hash = arguments.first
  end

  def self.command_description
    '               - Show this help message'
  end

  def run
    puts "This program can be run with the following arguments:"
    @command_flag_description_hash.each do |program_flag, flag_description|
      puts "#{program_flag}#{flag_description}"
    end
  end
end