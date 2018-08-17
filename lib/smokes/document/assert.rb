module Smokes
  module Document
    module Assert
      ASSERT = %w[current_url visible? title].freeze

      def check_assert
        @assert = @document['assert'] if @document.key?('assert')
      end

      def validate_assertion
        if invalid_assertion || !ASSERT.include?(assertions[0])
          puts("Invalid Assertion for #{@name}".colorize(:red))
          abort
        end
      end

      def run_assertion
        result = @browser.send(@target)
        if result == @assertion
          puts("#{@name} Passed successfully. ".colorize(:green))
        else
          puts("#{@name} Failed. ".colorize(:red))
          puts("EXPECTED: #{@assertion}  -  FOUND: #{result}")
        end
      rescue StandardError
        puts "Something went wrong while running the test #{@name}".colorize(:red)
      end

      def invalid_assertion
        assertions.length != 2
      end

      def initiate_assertions
        validate_assertion
        run_assertion
      end
    end
  end
end
