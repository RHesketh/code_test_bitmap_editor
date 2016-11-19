class Canvas
  MIN_SIZE = 1
  MAX_SIZE = 250
  BLANK_CHARACTER = "O"

  @image = nil

  def new_image(width, height)
    raise ArgumentError.new("Width and height must be between #{MIN_SIZE}-#{MAX_SIZE}") if width < MIN_SIZE || width > MAX_SIZE || height < MIN_SIZE || height > MAX_SIZE
    raise ArgumentError.new("Width and height must both be integers.") unless width.is_a?(Integer) && height.is_a?(Integer)
    @image = blank_canvas(width, height)
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