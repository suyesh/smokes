module Smokes
  class TestParser
    def initialize(_test, selenium_browser, selenium_wait)
      @test = _test
      @selenium_browser = selenium_browser
      @selenium_wait = selenium_wait
    end

    def run
      puts @test
    end
  end
end
