module RT
  class AI
    DIRECTIONS = [Vector2.new(-1, 0), Vector2.new(1, 0), Vector2.new(0, -1), Vector2.new(0, 1)].freeze

    def initialize(unit, grid, off_obstacles: false)
      @unit = unit
      @grid = grid
      @off_obstacles = off_obstacles
    end

    def direction
      direction_from_path(shortest_path(off_obstacles: off_obstacles) || shortest_path(off_obstacles: true))
    end

    def shortest_path(off_obstacles: false)
      visited = Array.new(cols) { Array.new(rows, false) }
      queue = [[source, [source]]]

      while queue.any?
        cell, path = queue.shift
        return path if cell == destination

        update_queue_and_visited(queue, visited, cell, path, off_obstacles)
      end

      false
    end

    private

    attr_reader :unit, :grid, :off_obstacles

    def player = grid.player
    def source = unit.position
    def destination = player.position
    def rows = grid.rows
    def cols = grid.cols

    def direction_from_path(path)
      next_cell = path[1]
      return :left if next_cell.x < unit.position.x
      return :right if next_cell.x > unit.position.x
      return :up if next_cell.y < unit.position.y

      :down if next_cell.y > unit.position.y
    end

    def update_queue_and_visited(queue, visited, cell, path, off_obstacles)
      DIRECTIONS.each do |direction|
        next_cell = cell + direction
        if valid?(next_cell, off_obstacles) && !visited[next_cell.y][next_cell.x]
          queue << [next_cell, path + [next_cell]]
          visited[next_cell.y][next_cell.x] = true
        end
      end

    end

    def valid?(cell, off_obstacles)
      cell.x.between?(0, cols - 1) &&
        cell.y.between?(0, rows - 1) &&
        (off_obstacles || grid.passable?(cell)) ||
        destination == cell
    end
  end
end
