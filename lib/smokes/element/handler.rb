require_relative './assert'
require_relative './action'

module Smokes
  module Element
    class Handler
      include Smokes::Utils
      include Smokes::Element::Assert
      include Smokes::Element::Action

      def initialize(spec, browser, wait)
        @browser = browser
        @wait = wait
        @test = spec
      end

      def run
        puts @test
      end
    end
  end
end
