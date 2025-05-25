module RT
  module Event
    class Bus
      def initialize
        @subscriptions = Hash.new { |h, k| h[k] = {} }
        @queue = []
      end

      def subscribe(event:, subscriber:, method:)
        @subscriptions[event][subscriber] = method
      end

      def unsubscribe(event:, subscriber:) = @subscriptions[event].delete(subscriber)
      def unsubscribe_all(subscriber:) = @subscriptions.each { _1.delete(subscriber) }

      def emit(event:, args: [])
        queue << { event:, args: }
      end

      def calls_events
        queue.each do |event|
          @subscriptions[event[:event]].each { |subscriber, method| subscriber.send(method, *event[:args]) }
        end

        @queue = []
      end

      private

      attr_reader :queue
    end
  end
end
