require './app/canvas'

class InputHandler
  ARGUMENT_LENGTHS = {"I" => 2, "L" => 3, "V" => 4, "H" => 4, "S" => 0}

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
        when "H"
          draw_horizontal_line(arguments)
        when "S"
          render_image
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

  # Command: L
  def set_pixel(arguments)
    x = arguments[0].to_i
    y = arguments[1].to_i
    colour = arguments[2]

    @canvas.set_pixel(x, y, colour)
  end

  # Command: V
  def draw_vertical_line(arguments)
    x = arguments[0].to_i
    y1 = arguments[1].to_i
    y2 = arguments[2].to_i
    colour = arguments[3]

    @canvas.draw_vertical_line(x, y1, y2, colour)
  end

  # Command: H
  def draw_horizontal_line(arguments)
    x1 = arguments[0].to_i
    x2 = arguments[1].to_i
    y = arguments[2].to_i
    colour = arguments[3]

    @canvas.draw_horizontal_line(x1, x2, y, colour)
  end

  # Command: S
  def render_image
    puts @canvas.render
  end
end