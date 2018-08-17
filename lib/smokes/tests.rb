require 'selenium-webdriver'

module Smokes
  # This class loads all the tests
  class Tests
    def initialize(url, selected_tests, config_variables)
      @url = url
      @selected_tests = selected_tests
      @driver = config_variables[:browser].to_sym
      @time_out = config_variables[:wait_time_out].to_i
      @table = TTY::Table.new header: ['Test','Result']
      start_browser
    end

    def run
      @browser.get @url
      itirate_tests
    end

    private

    def start_browser
      @browser = Selenium::WebDriver.for @driver
      @wait = Selenium::WebDriver::Wait.new(timeout: @time_out)
    end

    def itirate_tests
      @selected_tests.each do |selected_test|
        filename = "smokes/#{selected_test}.smoke"
        Smokes::TestFileLoader.new(filename, @browser, @wait, @table).run
      end
    end
  end
end
