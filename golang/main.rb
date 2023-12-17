class Rectangle
  attr_accessor :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def area
    @width * @height
  end
end

r = Rectangle.new(10, 5)
puts "長方形の面積: #{r.area}"
