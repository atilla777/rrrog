# Test runner for Rrrog! project
# This file is the entry point for running tests with the Taylor framework
set_trace_log_level 5

require 'rrrog/rrrog'
require 'test/grid_test'
require 'test/service_save_game_test'
require 'test/service_load_game_test'

if windows?
  module MTest
    class Unit
      def puts *a
        super(*a)
      end

      def print *a
        super(*a)
      end
    end
  end
end

init_window(10, 10, 'blah') if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?
result = MTest::Unit.new.run.zero?
close_window if !ENV.fetch('DISPLAY', '').empty? || browser? || windows?

persist_buildkite_test_analytics unless browser?

if browser?
  puts "ANALYTICS: #{$buildkite_test_analytics.to_json}"
  puts "EXIT CODE: #{result ? 1 : 0}"
  exit!
elsif result
  exit! 1
end
