require 'rt/grid'

# Mock Vector2 class for testing
class Vector2
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

# Mock Unit class for testing
class MockUnit
  attr_accessor :position, :new_position

  def initialize(x, y, passable = true, actionable = false)
    @position = Vector2.new(x, y)
    @new_position = Vector2.new(x, y)
    @passable = passable
    @actionable = actionable
  end

  def passable?
    @passable
  end

  def actionable?
    @actionable
  end
end

class GridTest < MTest::Unit::TestCase
  def setup
    @grid = RT::Grid.new
  end

  def test_grid_initialization
    assert_equal 19, @grid.rows
    assert_equal 26, @grid.cols
  end

  def test_put_and_take
    unit = MockUnit.new(5, 5)
    @grid.put(unit)

    taken_unit = @grid.take(Vector2.new(5, 5))
    assert_equal unit, taken_unit
  end

  def test_passable
    # Empty position should be passable
    assert @grid.passable?(Vector2.new(10, 10))

    # Add a passable unit
    passable_unit = MockUnit.new(10, 10, true)
    @grid.put(passable_unit)
    assert @grid.passable?(Vector2.new(10, 10))

    # Add a non-passable unit
    non_passable_unit = MockUnit.new(11, 11, false)
    @grid.put(non_passable_unit)
    assert !@grid.passable?(Vector2.new(11, 11))
  end

  def test_actionable
    # Empty position should not be actionable
    assert !@grid.actionable?(Vector2.new(10, 10))

    # Add a non-actionable unit
    non_actionable_unit = MockUnit.new(10, 10, true, false)
    @grid.put(non_actionable_unit)
    assert !@grid.actionable?(Vector2.new(10, 10))

    # Add an actionable unit
    actionable_unit = MockUnit.new(11, 11, false, true)
    @grid.put(actionable_unit)
    assert @grid.actionable?(Vector2.new(11, 11))
  end

  def test_remove
    unit = MockUnit.new(5, 5)
    @grid.put(unit)

    @grid.remove(Vector2.new(5, 5))
    assert_nil @grid.take(Vector2.new(5, 5))
  end
end
