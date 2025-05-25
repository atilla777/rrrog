module RT
  module Taylor
    class Debugger
      FONT_PATH = './assets/square.ttf'
      FONT_SIZE = 11
      TOP_MARGIN = 2

      def initialize
        # @font = ::Font.load(FONT_PATH)
        @font = Font.new(FONT_PATH)
        # font.filter = TEXTURE_FILTER_BILINEAR
        @messages = {}
      end

      def message(label, text) = messages[label] = text
      def m(label, text) = message(label, text)
      def reset_message(label) = messages.delete(label)
      def r(label) = reset_message(label)

      def render
        return if messages.empty?

        messages.each_key.with_index do |label, i|
          font.draw(
            text: "#{label.to_s}: #{messages[label].to_s}",
            x: 0,
            y: i * FONT_SIZE + TOP_MARGIN,
            size: FONT_SIZE,
            color: WHITE
          )
        end
      end

      private

      attr_reader :font, :messages
    end
  end
end