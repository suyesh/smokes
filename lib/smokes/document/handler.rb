module Smokes
  module Document
    class Handler
      include Smokes::Document::Assert
      include Smokes::Document::Action

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
    end
  end
end
