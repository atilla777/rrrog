module Items
  class Chest < RT::Unit::Base
    CHAR = 'C'
    CLOSED_CHAR = 'c'
    COLOR = BROWN
    HEALTH = 1
    DAMAGE = 0
    ACTIONABLE = true
    INITIAL_STATE = :open

    def char
      @state == :open ? CHAR : CLOSED_CHAR
    end

    private

    def on_act(actor)
      actor.items.concat(items)
      @items = []
      @state = :closed
    end
  end
end
