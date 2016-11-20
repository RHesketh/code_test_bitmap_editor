class Canvas
  MIN_SIZE = 1
  MAX_SIZE = 250
  BLANK_CHARACTER = "O"

  @image = nil

  def new_image(width, height)
    raise ArgumentError.new("Width and height must both be integers.") unless width.is_a?(Integer) && height.is_a?(Integer)
    raise ArgumentError.new("Width and height must be between #{MIN_SIZE}-#{MAX_SIZE}.") if width < MIN_SIZE || width > MAX_SIZE || height < MIN_SIZE || height > MAX_SIZE
    @image_width = width
    @image_height = height
    
    @image = blank_canvas(@image_width, @image_height)
  end

  def set_pixel(x,y,colour)
    return if @image.nil?
    raise ArgumentError.new("x and y must both be integers.") unless x.is_a?(Integer) && y.is_a?(Integer)
    raise ArgumentError.new("Colour must be a capital letter.") unless colour.is_a?(String) && colour.match(/\p{Upper}/)
    raise ArgumentError.new("x coordinate must be between 1-#{@image_width}.") if x < 1 || x > @image_width
    raise ArgumentError.new("y coordinate must be between 1-#{@image_height}.") if y < 1 || y > @image_height

    @image[y-1][x-1] = colour
  end

  def render
    return nil if @image.nil?
    @image.map{|row| row.join + "\n"}.join
  end

  private

  def blank_canvas(width, height)
    canvas = []

    height.times do
      canvas << (BLANK_CHARACTER * width).chars
    end

    canvas
  end
end