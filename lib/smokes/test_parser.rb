module Smokes
  class TestParser
    def initialize(_test, selenium_browser, selenium_wait)
      @test = validate(_test)
      @selenium_browser = selenium_browser
      @selenium_wait = selenium_wait
    end

    def run
      puts @test
    end

    private

    def validate(_test)
      @test
    end
  end
end
