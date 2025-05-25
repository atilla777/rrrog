module Items
  class Sword < RT::Unit::Base
    include RT::Unit::PickupMixin

    CHAR = '/'
    COLOR = YELLOW
    HEALTH = 1
    DAMAGE = 0
    ACTIONABLE = true
  end
end
