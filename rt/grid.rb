module RT
  # block_sound
  class Grid
    ROWS = 19
    COLS = 26

    attr_reader :rows, :cols

    attr_accessor :player

    def initialize
      @grid = Hash.new { |h, k| h[k] = {} }
      @rows = ROWS
      @cols = COLS
    end

    def move(from:, to:)
      unit = take(from)
      grid[to.x][to.y] = unit
      remove(from)
      set_unit_positions(unit, to)
    end

    def take(position) = grid.dig(position.x, position.y)

    def put(unit)
      grid[unit.position.x][unit.position.y] = unit
    end

    def actionable?(position) = take(position)&.actionable?

    def passable?(position)
      return false if position.x.negative? || position.y.negative? || position.y > rows || position.x > cols
      return true unless take(position)

      take(position)&.passable?
    end

    def remove(position)
      grid[position.x].delete(position.y)
      grid.delete(position.x) if grid[position.x].empty?
    end

    def clear = grid.clear

    private

    attr_reader :grid

    def set_unit_positions(unit, position)
      unit.position.x = position.x
      unit.position.y = position.y
      unit.new_position.x = position.x
      unit.new_position.y = position.y
    end
  end
end
