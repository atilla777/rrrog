module RT
  module Menu
    class Renderer
      COLOR = WHITE
      OUTLINE_COLOR = YELLOW

      attr_reader :font_size, :screen_height, :screen_width

      def initialize(font:, font_size:, screen_width:, screen_height:)
        @font = font
        @font_size = font_size
        @screen_width = screen_width
        @screen_height = screen_height
      end

      def call(renderables) = renderables.each_with_index { draw_renderable(_1) }

      private

      attr_reader :font

      def draw_renderable(renderable)
        if renderable.focus_on?
          rect = Rectangle.new(
            renderable.outline_position.x,
            renderable.outline_position.y,
            renderable.outline_width,
            renderable.outline_height
          )
          rect.draw(outline: true, colour: OUTLINE_COLOR)
        end

        font.draw(
          text: renderable.text,
          x: renderable.position.x,
          y: renderable.position.y,
          size: font_size,
          color: COLOR
        )
      end
    end
  end
end
