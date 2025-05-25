module RT
  module Scene
    class Base
      include Event::Join

      attr_reader :units, :event_bus

      def initialize(game:, renderer:, input_handler:, music_player: nil)
        @game = game
        join_event_bus(game.event_bus)
        @renderer = renderer
        @input_handler = input_handler
        @music_player = music_player
        music_player.play if music_player
      end

      def update
        music_player.update if music_player
      end

      def draw = raise NotImplementedError

      private

      attr_reader :game, :renderer, :input_handler, :music_player
    end
  end
end
