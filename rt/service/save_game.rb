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

        begin
          Dir.mkdir('./saves') unless Dir.exist?('./saves')
          File.open('./saves/save.json', 'w') do |file|
            file.puts json_data
          end
        rescue => e
          puts "Error saving game: #{e.message}"
        end
      end
    end
  end
end
