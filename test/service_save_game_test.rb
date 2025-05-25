class RT::Service::SaveGameTest < MTest::Unit::TestCase
  def setup
    @game = MockGame.new
  end

  def test_save_game_service
    service = RT::Service::SaveGame.new(@game)
    service.save

    assert(File.exist?('./saves/save.json'))

    json_data = File.read('./saves/save.json')
    data = JSON.parse(json_data)

    assert_equal(Array, data['units'].class)
    assert_equal(1, data['units'].size)
    assert_equal('MockUnit', data['units'][0]['class'])
    assert_equal(10, data['units'][0]['position']['x'])
    assert_equal(10, data['units'][0]['position']['y'])
  end

  class MockGame
    def game_run?
      true
    end

    def game_scene
      MockGameScene.new
    end
  end

  class MockGameScene
    def units
      [MockUnit.new]
    end
  end

  class MockUnit
    def position
      MockVector2.new
    end

    def health
      100
    end

    def items
      []
    end

    def save_data
      {
        class: 'MockUnit',
        position: {
          x: position.x,
          y: position.y
        },
        health: health,
        items: items.map(&:save_data)
      }
    end
  end

  class MockVector2
    def x
      10
    end

    def y
      10
    end
  end
end
