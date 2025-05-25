module Statics
  class Oak < RT::Unit::Base
    CHAR = '^'
    COLOR = GREEN
    HEALTH = 20
    DAMAGE = 0

    private

    def on_act(actor)
      actor.play_damage
      @health -= actor.tree_damage
    end
  end
end
