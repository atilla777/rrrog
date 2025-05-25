module RT
  module Scene
    class Game < Base
      def initialize(...)
        super

        @units = Set.new
        @grid = Grid.new
        input_handler.join_event_bus(game.event_bus)
      end

      def update
        units.each(&:update) if input_handler.call(player)
      end

      def draw = renderer.call(units)

      def add_unit(unit)
        units << unit
        grid.put(unit)
        unit.grid = grid
        unit.scene = self
      end

      def remove_unit(unit)
        units.delete(unit)
        grid.remove(unit.position)
      end

      def clear_units
        units.clear
        grid.clear
      end

      def player = grid.player

      private

      attr_reader :units, :grid
    end
  end
end
