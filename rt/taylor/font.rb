module RT
  module Taylor
    class Font
      SIZE = 24
      COLOR = WHITE

      def initialize(path)
        @font = ::Font.load(path)
        font.filter = TEXTURE_FILTER_BILINEAR
        @position = Vector2.new(0, 0)
      end

      def draw(text:, x:, y:, size:, color:)
        position.x = x
        position.y = y
        font.draw(text, position:, size:, colour: color)
      end

      private

      attr_reader :font, :position
    end
  end
end
