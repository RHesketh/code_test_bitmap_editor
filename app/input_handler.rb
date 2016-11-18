class InputHandler
  def parse(input)
    command, *arguments = input.split(" ")

    case command
    when "I"
      if new_image_arguments_are_invalid?(arguments)
        puts "ERROR: invalid argument(s)"
        puts "  Valid format is `I [x] [y]`"
        puts "  E.g. `I 5 5`"
      end
    else
      puts "unrecognised command :("
    end
  end

  private

  def new_image_arguments_are_invalid?(arguments)
    return true if arguments.length != 2
    return true if !is_a_number?(arguments[0]) || !is_a_number?(arguments[1])

    return false
  end

  def is_a_number?(argument)
    return /\A\d+\z/.match(argument)
  end
end