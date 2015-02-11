require_relative 'contact_commands'


class ContactApplication

  def initialize(arguments)
    @arguments = arguments
    # @application_arguments = arguments
    @recognized_commands = { :new => '                - Create a new contact',
                             :list => '               - List all contacts',
                             :show => ' <id>          - Show a contact whose id value is <id>',
                             :find => ' <search text> - Find a contact whose name or email contains <search text>',
                             :help => '               - Show this help message' }
  end

  def run
    case @arguments.shift
    when :new.to_s
      CreateNewContactCommand.new(*@arguments).run
    when :list.to_s
      ListAllContactsCommand.new(*@arguments).run
    when :show.to_s
      ShowContactCommand.new(*@arguments).run
    when :find.to_s
      FindContactsCommand.new(*@arguments).run
    when :help.to_s
      show_help
    else
      raise(ArgumentError, "Invalid argument not recognized: #{@arguments.join(' ')}")
    end
  rescue ArgumentError => error
    puts "\n#{error.message}\n\n"
    show_help
  end

  private
  def show_help
    puts "This program can be run with the following arguments:"
    @recognized_commands.each do |program_flag, flag_description|
      puts "#{program_flag}#{flag_description}"
    end
  end
end
