module RT
  module Scene
    class MainMenu < Base
      class << self
        def items
          @@items ||= []
        end

        def item(text, event, options = {}) = items << { text:, event:, **options }
      end

      def initialize(...)
        super

        @items = []
        prepare_items
      end

      def item(...) = items << Menu::Item.new(...)

      def update
        super

        @visible_items = positionator.call
        input_handler.call(visible_items)
      end

      def draw = renderer.call(visible_items)

      private

      attr_reader :items, :visible_items

      def positionator
        @positionator ||= Menu::PrepareItemsPositions.new(
          items:,
          font_size: renderer.font_size,
          screen_width: renderer.screen_width,
          screen_height: renderer.screen_height
        )
      end

      def prepare_items = self.class.items.each { item(scene: self, **_1) }
    end
  end
end
