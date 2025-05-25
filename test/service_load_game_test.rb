class ServiceLoadGameTest < MTest::Unit::TestCase
  def setup
    @game = MockGame.new

    File.open('./saves/save.json', 'w') do |file|
      file.puts({
        units: [
          {
            class: 'MockUnit',
            position: { x: 10, y: 10 },
            health: 100,
            items: []
          }
        ]
      }.to_json)
    end
  end

  def teardown
    File.delete('./saves/save.json') if File.exist?('./saves/save.json')
  end

  def test_load_game_service
    service = RT::Service::LoadGame.new(@game)
    service.load

    assert(@game.start_load_game_called)
    assert_equal(1, @game.loaded_data['units'].size)
    assert_equal('MockUnit', @game.loaded_data['units'][0]['class'])
    assert_equal(10, @game.loaded_data['units'][0]['position']['x'])
    assert_equal(10, @game.loaded_data['units'][0]['position']['y'])
    assert_equal(100, @game.loaded_data['units'][0]['health'])
  end

  class MockGame
    attr_reader :start_load_game_called, :loaded_data

    def initialize
      @start_load_game_called = false
      @loaded_data = nil
    end

    def start_load_game(data)
      @start_load_game_called = true
      @loaded_data = data
    end
  end
end
