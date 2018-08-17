module Smokes
  # Parses individual test and runs it using selenium
  class TestFileLoader
    include Smokes::Utils

    def initialize(filename, browser, wait, table)
      @filename = filename
      @tests = YAML.load_file(filename)
      @browser = browser
      @wait = wait
      @table = table
    end

    def run
      @tests.each do |test|
        Smokes::Document::Handler.new(test, @browser, @wait, @table).run if test.key?('document')
        @table.render :ascii, multiline: true, padding: [1,2,1,2]
      end
    end
  end
end
