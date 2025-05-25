module RT
  module Taylor
    class MusicPLayer
      def initialize(music_file)
        @music = Music.load(music_file)
      end

      def play = music.play
      def stop = music.stop
      def update = music.update

      private

      attr_reader :music
    end
  end
end
