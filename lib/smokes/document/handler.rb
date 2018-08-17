require_relative './assert'
require_relative './action'

module Smokes
  module Document
    class Handler
      include Smokes::Utils
      include Smokes::Document::Assert
      include Smokes::Document::Action

      def initialize(_test, browser, wait)
        @browser = browser
        @wait = wait
        @test = _test
        @name = name
        @document = document
        @action = check_action
        @assert = check_assert
        assertion_or_action(@assert, @action)
      end

      def run
        run_assertions if @assert
        run_actions if @action
      end

      private

      def name
        @name = validate_attribute(@test, 'name')['name']
      end

      def document
        @document = validate_attribute(@test, 'document', @name)['document']
      end

      def check_assert
        @assert = @document['assert'] if @document.key?('assert')
      end

      def check_action
        @action = @document['action'] if @document.key?('action')
      end
    end
  end
end
