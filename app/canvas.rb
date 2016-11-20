class Canvas
  MIN_SIZE = 1
  MAX_SIZE = 250
  BLANK_CHARACTER = "O"

  def new_image(width, height)
    raise TypeError.new("Width and height must both be integers.") unless width.is_a?(Integer) && height.is_a?(Integer)
    raise ArgumentError.new("Width and height must be between #{MIN_SIZE}-#{MAX_SIZE}.") if width < MIN_SIZE || width > MAX_SIZE || height < MIN_SIZE || height > MAX_SIZE
    @image_width = width
    @image_height = height
    
    @image = blank_canvas(@image_width, @image_height)
  end

  def set_pixel(x,y,colour)
    return if @image.nil?
    raise TypeError.new("x and y must both be integers.") unless x.is_a?(Integer) && y.is_a?(Integer)
    raise ArgumentError.new("Colour must be a capital letter.") unless colour.is_a?(String) && colour.match(/^\p{Upper}$/)
    raise ArgumentError.new("x coordinate must be between 1-#{@image_width}.") if x < 1 || x > @image_width
    raise ArgumentError.new("y coordinate must be between 1-#{@image_height}.") if y < 1 || y > @image_height

    @image[y-1][x-1] = colour
  end

  def draw_vertical_line(x,y1,y2,colour)
    return if @image.nil?
    raise TypeError.new("All coordinates must be integers.") unless x.is_a?(Integer) && y1.is_a?(Integer) && y2.is_a?(Integer)
    raise ArgumentError.new("Colour must be a capital letter.") unless colour.is_a?(String) && colour.match(/^\p{Upper}$/)
    raise ArgumentError.new("x coordinate must be between 1-#{@image_width}") if x < 1 || x > @image_width
    raise ArgumentError.new("y coordinates must be between 1-#{@image_height}") if y1 < 1 || y2 < 1 || y1 > @image_height || y2 > @image_height

    # Convert 1-indexed canvas coordinates to 0-indexed internal image coordinates
    line_start = [y1, y2].min - 1
    line_end = [y1, y2].max - 1
    column = x - 1

    @image.each_with_index do |row, row_index|
      next if row_index < line_start || row_index > line_end

      @image[row_index][column] = colour
    end
  end

  def draw_horizontal_line(x1,x2,y,colour)
    return if @image.nil?
    raise TypeError.new("All coordinates must be integers.") unless x1.is_a?(Integer) && x2.is_a?(Integer) && y.is_a?(Integer)
    raise ArgumentError.new("Colour must be a capital letter.") unless colour.is_a?(String) && colour.match(/^\p{Upper}$/)
    raise ArgumentError.new("x coordinates must be between 1-#{@image_width}") if x1 < 1 || x2 < 1 || x1 > @image_width || x2 > @image_width 
    raise ArgumentError.new("y coordinate must be between 1-#{@image_height}") if y < 1 || y > @image_height

    # Convert 1-indexed canvas coordinates to 0-indexed internal image coordinates
    line_start = [x1, x2].min - 1
    line_end = [x1, x2].max - 1
    row = y - 1

    @image[row].each_with_index do |column, column_index|
      next if column_index < line_start || column_index > line_end

      @image[row][column_index] = colour
    end
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