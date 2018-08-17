module Smokes
  module Document
    module Assert

      ASSERT = %w[current_url visible? title].freeze

      def validate_assertion
        if invalid_assertion || !ASSERT.include?(assertions[0])
          puts("Invalid Assertion for #{@name}".colorize(:red))
          abort
        end
        @target = assertions[0]
        @assertion = assertions[1]
      end

      def run_assertion
        result = @browser.send(@target)
        if result == @assertion
          puts("#{@name} Passed successfully. ".colorize(:green))
        else
          puts("#{@name} Failed. ".colorize(:red))
        end
      rescue StandardError
        puts "Something went wrong while running the test #{@name}".colorize(:red)
      end

      def check_assert
        @assert = Smokes::Utils.validate_attribute(@document, 'assert', @name)['assert']
      end

      def invalid_assertion
        assertions.length != 2
      end

      def assertions
        @assert.split('=')
      end

      def run_assertions
        validate_assertion
        run_assertion
      end
    end
  end
end
