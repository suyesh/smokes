module Smokes
  # Parses individual test and runs it using selenium
  class TestParser
    def initialize(filename, selenium_browser, selenium_wait)
      @filename = filename
      @test = YAML.load_file(filename)
      @selenium_browser = selenium_browser
      @selenium_wait = selenium_wait
    end

    def run
      print @test
    end
end
