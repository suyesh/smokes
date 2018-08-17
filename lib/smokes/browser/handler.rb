module Smokes
  module Browser
    class Handler
      ACTIONS = %w[close execute_acync_script execute_script quit].freeze
      ASSERT  = %w[current_url visible? title].freeze

      def initialize(_test, browser, wait)
        @browser = browser
        @wait = wait
        @test = _test
      end

      def run
        parse_attributes
      end

      private

      def parse_attributes
        name
        document
        check_action

        unless @action
          validate_assert
          validate_assertion
          run_assertion
        end
      end

      def name
        @name = validate_attribute(@test, 'name')['name']
      end

      def document
        @document = validate_attribute(@test, 'document', @name)['document']
      end

      def validate_attribute(_test, attribute, name = nil)
        unless _test.key?(attribute)
          puts("#{name || 'Test'} is missing '#{attribute}'".colorize(:red))
          abort
        end
        _test
      end

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

      def validate_assert
        @assert = validate_attribute(@document, 'assert', @name)['assert']
      end

      def invalid_assertion
        assertions.length != 2
      end

      def assertions
        @assert.split('=')
      end

      def check_action
        if @document.key?('action')
          @action = @document['action']
          run_actions
        end
      end

      def run_actions
        action = @action.split('=')
        valid_action(action[0])
        if close_or_quit(action[0])
          begin
            @browser.send(action[0])
            puts("#{action[0]} was successfully performed for #{@name}. Passed".colorize(:green))
          rescue StandardError
            puts("#{action[0]} Could not be performed for #{@name}. Failed".colorize(:red))
          end
        elsif action_requiring_parameter(action)
          begin
           @browser.send(action[0], action[1])
           puts("#{action[0]} was successfully performed for #{@name}. Passed".colorize(:green))
         rescue StandardError
           puts("#{action[0]} Could not be performed for #{@name}. Failed".colorize(:red))
         end
        end
      end

      def close_or_quit(action)
        action.length == 1 && %w[close quit].include?(action)
      end

      def valid_action(action)
        unless ACTIONS.include?(action)
          puts("Invalid Action type for #{@name}".colorize(:red))
          abort
        end
      end

      def action_requiring_parameter(action)
        valid = %w[execute_acync_script execute_script].include?(action[0]) && action.length == 2
        unless valid
          puts("#{action[0]} is missing parameter for #{@name}".colorize(:red))
          abort
        end
        valid
      end
    end
  end
end
