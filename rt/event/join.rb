module RT
  module Event
    module Join
      def join_event_bus(event_bus)
        @event_bus = event_bus
      end
    end
  end
end
