module Smokes
  # Parses individual test and runs it using selenium
  class Tests
    include Smokes::Utils

    def initialize(filename, browser, wait)
      @filename = filename
      @test = YAML.load_file(filename)
      @browser = browser
      @wait = wait
    end

    def run
      print @test
    end
  end
end
