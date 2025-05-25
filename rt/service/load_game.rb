module RT
  module Service
    class LoadGame
      def self.call(...) = new(...).load

      def initialize(game)
        @game = game
      end

      def load
        return unless File.exist?("./saves/save.json")

        begin
          json_data = File.read("./saves/save.json")
          data = JSON.parse(json_data)

          @game.load_data(data)
        rescue => e
          puts "Error loading game: #{e.message}"
        end
      end
    end
  end
end
