module RT
  class ASCIIRenderer
    def initialize(font:, font_size:)
      @font = font
      @font_size = font_size
    end

    def call(renderables) = renderables.each { draw_renderable(_1) }

    private

    attr_reader :font, :font_size

    def draw_renderable(renderable)
      font.draw(
        text: renderable.char,
        x: absolute_x(renderable.position.x),
        y: absolute_y(renderable.position.y),
        size: font_size,
        color: renderable.color
      )
    end

    def absolute_x(x) = x * font_size
    def absolute_y(y) = y * font_size
  end
end
