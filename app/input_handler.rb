require './app/canvas'

class InputHandler
  ARGUMENT_LENGTHS = {"I" => 2, "L" => 3, "V" => 4}

  def initialize(options = {})
    @canvas = options[:canvas] || Canvas.new
  end

  def parse(input)
    command, *arguments = input.split(" ")

    if !ARGUMENT_LENGTHS.keys.include?(command)
      $stderr.puts "unrecognised command :("
    elsif arguments.count != ARGUMENT_LENGTHS[command]
      $stderr.puts "ERROR: invalid number of arguments"
    else
      begin
        case command
        when "I"
          create_new_image(arguments)
        when "L"
          set_pixel(arguments)
        when "V"
          draw_vertical_line(arguments)
        end
      rescue ArgumentError => e
        $stderr.puts "Invalid argument(s): #{e.message}"
      end
    end
  end

  private

  # Command: I
  def create_new_image(arguments)
    width = arguments[0].to_i
    height = arguments[1].to_i

    @canvas.new_image(width, height)
  end  

  def set_pixel(arguments)
    x = arguments[0].to_i
    y = arguments[1].to_i
    colour = arguments[2]

    @canvas.set_pixel(x, y, colour)
  end

  def draw_vertical_line(arguments)
    x = arguments[0].to_i
    y1 = arguments[1].to_i
    y2 = arguments[2].to_i
    colour = arguments[3]

    @canvas.draw_vertical_line(x, y1, y2, colour)
  end
end