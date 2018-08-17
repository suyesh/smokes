module Smokes
  # Parses individual test and runs it using selenium
  class TestFileLoader
    include Smokes::Utils

    def initialize(filename, browser, wait, table)
      @filename = filename
      @tests = YAML.load_file(filename)
      @browser = browser
      @wait = wait
    end

    def run
      @tests.each do |test|
        Smokes::Document::Handler.new(test, @browser, @wait).run if test.key?('document')
      end
    end
  end
end
