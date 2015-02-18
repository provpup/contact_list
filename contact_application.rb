require_relative 'contact_commands'


class ContactApplication

  def initialize(arguments)
    @arguments = arguments
  end

  def run
    recognized_commands = { :new => CreateNewContactCommand.command_description,
                            :update => UpdateContactCommand.command_description,
                            :remove => DeleteContactCommand.command_description,
                            :list => ListAllContactsCommand.command_description,
                            :show => ShowContactCommand.command_description,
                            :find => FindContactsCommand.command_description,
                            :help => ShowHelpCommand.command_description }

    # Look at the arguments passed into this application and then
    # take the appropriate action
    case @arguments.shift.to_sym
    when :new
      CreateNewContactCommand.new(*@arguments).run
    when :update
      UpdateContactCommand.new(*@arguments).run
    when :remove
      DeleteContactCommand.new(*@arguments).run
    when :list
      ListAllContactsCommand.new(*@arguments).run
    when :show
      ShowContactCommand.new(*@arguments).run
    when :find
      FindContactsCommand.new(*@arguments).run
    when :help
      ShowHelpCommand.new(recognized_commands).run
    else
      raise(ArgumentError, "Invalid argument not recognized")
    end
  rescue ArgumentError => error
    # Show a help message if arguments are malformed
    puts "\n#{error.message}"
    puts error.backtrace.inspect
    puts "\n"
    ShowHelpCommand.new(recognized_commands).run
  end
end
