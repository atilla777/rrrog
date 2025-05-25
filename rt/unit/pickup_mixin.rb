module RT
  module Unit
    module PickupMixin
      def on_act(actor)
        actor.items << self
        scene.remove_unit(self)
        @position = nil
      end
    end
  end
end
