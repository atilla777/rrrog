module RT
  module Service
    class SaveGame
      def self.call(...) = new(...).save

      def initialize(game)
        @game = game
      end

      def save
        return unless @game.game_run?

        data = {
          units: @game.game_scene.units.map(&:save_data)
        }

        json_data = data.to_json

        File.open('./saves/save.json', 'w') do |file|
          file.puts json_data
        end
      end
    end
  end
end