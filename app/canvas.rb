class Canvas
  BLANK_CHARACTER = "O"
  @image = nil

  def new_image(width, height)
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