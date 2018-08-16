module Smokes
  # Parses individual test and runs it using selenium
  class TestParser
    def initialize(filename, browser, wait)
      @filename = filename
      @test = symbolize_hash(YAML.load_file(filename))
      @browser = browser
      @wait = wait
    end

    def run
      print @test
    end
  end
end
