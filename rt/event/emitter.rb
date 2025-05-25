module RT
  module Event
    module Emitter
      include Join

      def emit(event, *args) = event_bus.emit(event:, args:)
    end
  end
end
