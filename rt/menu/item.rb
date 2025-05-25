module RT
  module Menu
    class Item
      class NoShowMethodError < StandardError; end

      include Event::Emitter

      attr_accessor :focus, :outline_width, :outline_height

      attr_reader :text, :show, :position, :outline_position

      def initialize(scene:, text:, event:, show: nil)
        @scene = scene
        join_event_bus(scene.event_bus)
        @text = text
        @event = event
        @show = show
        @position = Vector2.new(0, 0)
        @outline_position = Vector2.new(0, 0)
        @focus = false
      end

      def visible?
        if show.is_a?(Symbol)
          raise NoShowMethodError unless scene.respond_to?(show)

          return scene.send(show)
        end

        return show.call if show.is_a?(Proc)

        true
      end

      def act = emit(event)
      def focus_on? = focus

      private

      attr_reader :scene, :event_bus, :event
    end
  end
end
