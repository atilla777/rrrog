module RT
  module Event
    module Subscriber
      include Join

      module ClassMethods
        def subscriptions
          @@subscriptions ||= []
        end

        def on(event, method) = subscriptions << { event:, method: }
      end

      def self.included(base)
        base.class_eval do

          extend(ClassMethods)

          attr_reader :event_bus
          private :event_bus
        end
      end

      def join_event_bus(event_bus)
        super

        self.class.subscriptions.each { event_bus.subscribe(subscriber: self, **_1) }
      end
    end
  end
end
