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
          @subscriptions[event[:event]].each do |subscriber, method|
            begin
              subscriber.send(method, *event[:args])
            rescue => e
              puts "Error calling event #{event[:event]} on #{subscriber.class.name}##{method}: #{e.message}"
            end
          end
        end

        @queue = []
      end

      private

      attr_reader :queue
    end
  end
end
