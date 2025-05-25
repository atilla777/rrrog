module Enemies
  class Wolf < RT::Unit::Base
    CHAR = 'w'
    COLOR = RED
    HEALTH = 3
    DAMAGE = 2
    ACTIONABLE = true

    private

    def on_act(actor)
      actor.play_damage
      @health -= actor.damage
    end

    def init_ai
      RT::AI.new(self, grid)
    end
  end
end