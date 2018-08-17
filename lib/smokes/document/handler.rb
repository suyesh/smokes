require_relative './assert'
require_relative './action'

module Smokes
  module Document
    class Handler
      include Smokes::Utils
      include Smokes::Document::Assert
      include Smokes::Document::Action

      def initialize(spec, browser, wait, table)
        @browser = browser
        @wait = wait
        @test = spec
        @name = name
        @document = document
        @action = check_action
        @assert = check_assert
        assertion_or_action(@assert, @action)
        @target = assertions[0] if @assert
        @assertion = assertions[1] if @assert
      end

      def run
        initiate_assertions if @assert
        initiate_actions if @action
      end

      private

      def name
        @name = validate_attribute(@test, 'name')['name']
      end

      def document
        @document = validate_attribute(@test, 'document', @name)['document']
      end

      def assertions
        @assert.split('=') if @assert
      end
    end
  end
end
