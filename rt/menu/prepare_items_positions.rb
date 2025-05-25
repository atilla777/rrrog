module RT
  module Menu
    class PrepareItemsPositions
      PADDING_X = 20
      PADDING_Y = 20
      FONT_WIDTH_MULTIPLIER = 0.6

      def initialize(items:, font_size:, screen_width:, screen_height:)
        @all_items = items
        @font_size = font_size
        @screen_width = screen_width
        @screen_height = screen_height
        @line_height = font_size + (2 * PADDING_Y)
      end

      def call
        @items = all_items.select { _1.visible? }
        total_height = line_height * items.size
        start_y = (screen_height - total_height) / 2

        items.each_with_index { |item, index| set_position(item, index, start_y) }
      end

      private

      attr_reader :items, :all_items, :font_size, :screen_width, :screen_height, :line_height

      def set_position(item, index, start_y)
        text_width = item.text.length * font_size * 0.7
        outline_width = text_width + 2 * padding_x
        outline_height = line_height

        outline_x = (screen_width - outline_width) / 2
        outline_y = start_y + index * outline_height

        text_x = outline_x + (outline_width - text_width) / 2
        text_y = outline_y + padding_y

        item.outline_position.x = outline_x
        item.outline_position.y = outline_y
        item.outline_width = outline_width
        item.outline_height = outline_height

        item.position.x = text_x
        item.position.y = text_y
      end

      def padding_x = PADDING_X
      def padding_y = PADDING_Y
    end
  end
end
