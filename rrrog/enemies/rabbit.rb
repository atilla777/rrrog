module Enemies
  class Rabbit < RT::Unit::Base
    CHAR = 'r'
    COLOR = WHITE
    HEALTH = 1
    DAMAGE = 1
    ACTIONABLE = true
    PREGNANT = 15

    def on_act(actor)
      actor.play_damage
      @health -= actor.damage
    end

    def init_ai
      RT::AI.new(self, grid)
    end

    def on_update
      @pregnant = pregnant + 1
      if pregnant == PREGNANT
        scene.add_unit(
          self.class.new(x: position.x + 1, y: position.y + 1)
        ) if grid.passable?(Vector2.new(position.x + 1, position.y + 1))
        @pregnant = 0
      end
    end

    def pregnant
      @pregnant ||= 0
    end
  end
end