module Smokes
  # Parses individual test and runs it using selenium
  class Tests
    include Smokes::Utils

    def initialize(filename, browser, wait)
      @filename = filename
      @tests = YAML.load_file(filename)
      @browser = browser
      @wait = wait
    end

    def run
      @tests.each do |test|
        Smokes::DocumentHandler.new(test, @browser, @wait).run if test.key?('document')
      end
    end
  end
end