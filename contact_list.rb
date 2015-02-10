require_relative 'contact'

@recognized_commands = { :new => '                - Create a new contact',
                         :list => '               - List all contacts',
                         :show => ' <id>          - Show a contact whose id value is <id>',
                         :find => ' <search text> - Find a contact whose name or email contains <search text>',
                         :help => '               - Show this help message' }


def show_help
  puts "This program can be run with the following arguments:"
  @recognized_commands.each do |program_flag, flag_description|
    puts "#{program_flag}#{flag_description}"
  end
end

def display_contact_details(contact)
  puts "Name:   #{contact.name}"
  puts "E-mail: #{contact.email}"
  puts "Index:  #{contact.id}"
  puts
end

def prompt_for_contact_details
  unique_email = false
  until unique_email
    print "\nPlease enter e-mail address for new contact: "
    email = STDIN.gets.chomp.strip
    unique_email = !Contact.email_already_exists?(email)
    puts "Email already exists in the contact database!" if !unique_email
  end
  print "Please enter name for new contact: "
  name = STDIN.gets.chomp.strip
  contact = Contact.create(name, email)
  puts "\nNew contact #{contact.to_s} added successfully with id: #{contact.id}"
rescue StandardError => error
  puts "Error encountered creating new contact: #{error.message}"
  error.backtrace.inspect
end

def list_all_contacts
  contacts = Contact.all
  contacts.each do |contact|
    puts "#{contact.id}: #{contact.to_s}"
  end
  puts "---"
  puts "#{contacts.length} records total"
end

def show_contact(contact_id)
  contact = Contact.get(contact_id)
  display_contact_details(contact)
rescue StandardError => error
  puts "Error encountered retrieving contact with id: #{contact_id}"
  puts error.message
  error.backtrace.inspect
end

def find_contact(contact_query)
  contacts = Contact.find(contact_query)
  contacts.each do |contact|
    display_contact_details(contact)
  end
  puts "---"
  puts "#{contacts.length} records found with data \"#{contact_query}\"\n"
rescue StandardError => error
  puts "Error encountered retrieving contacts with query data: #{contact_query}"
  puts error.message
  error.backtrace.inspect
end

# Get the command line arguments without the name of this script
command_line_args = ARGV

begin
  case command_line_args.shift
  when :new.to_s
    prompt_for_contact_details
  when :list.to_s
    list_all_contacts
  when :show.to_s
    contact_id = command_line_args.shift
    if contact_id.nil? || contact_id.to_i == 0
      # No argument or not a valid number
      raise(ArgumentError, "Invalid argument for #{:show.to_s}: #{contact_id}")
    end
    show_contact(contact_id.to_i)
  when :find.to_s
    contact_query = command_line_args.shift
    find_contact(contact_query)
  when :help.to_s
    show_help
  else
    raise(ArgumentError, "Invalid argument not recognized: #{command_line_args.join(' ')}")
  end
rescue ArgumentError => error
  puts "\n#{error.message}\n\n"
  show_help
end
