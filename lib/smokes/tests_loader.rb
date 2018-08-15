require 'selenium-webdriver'

module Smokes
  # This class loads all the tests
  class TestsLoader
    def initialize(url, selected_tests, config_variables)
      @url = url
      @selected_tests = selected_tests
      @config_variables = config_variables
      start_browser
    end

    def run
      @browser.get @url
      itirate_tests
    end

    private

    def start_browser
      @browser = Selenium::WebDriver.for @config_variables[:browser].to_sym
      @wait = Selenium::WebDriver::Wait.new(timeout: @config_variables[:wait_time_out])
    end

    def itirate_tests
      @selected_tests.each do |_test|
        filename = "smokes/#{_test}.smoke"
        check_yaml(filename)
        Smokes::TestParser.new(YAML.load_file(filename), @browser, @wait).run
      end
    end
  end
end
