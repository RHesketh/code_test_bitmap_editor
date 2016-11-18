require './app/canvas'

class InputHandler
  def initialize(options = {})
    @canvas = options[:canvas] || Canvas.new
  end

  def parse(input)
    command, *arguments = input.split(" ")

    case command
    when "I"
      if new_image_arguments_are_invalid?(arguments)
        puts "ERROR: invalid argument(s)"
        puts "  Valid format is `I [x] [y]`"
        puts "  E.g. `I 5 5`"
      else
        create_new_image(arguments)
      end
    else
      puts "unrecognised command :("
    end
  end

  private

  # Command: I
  def create_new_image(arguments)
    width = arguments[0].to_i
    height = arguments[1].to_i

    @canvas.new_image(width, height)
  end

  def new_image_arguments_are_invalid?(arguments)
    return true if arguments.length != 2
    return true if !is_a_number?(arguments[0]) || !is_a_number?(arguments[1])

    return false
  end

  def is_a_number?(argument)
    return /\A\d+\z/.match(argument)
  end
end