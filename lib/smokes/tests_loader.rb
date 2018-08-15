require 'selenium-webdriver'

module Smokes
  # This class loads all the tests
  class TestsLoader
    def initialize(url, selected_tests, config_variables)
      @url = url
      @selected_tests = selected_tests
      @config_variables = config_variables
    end

    def run
      browser = Selenium::WebDriver.for :chrome
      wait = Selenium::WebDriver::Wait.new(timeout: 15)
      browser.get @url
      input = wait.until do
        element = browser.find_element(:name, 'searchbox')
        element if element.displayed?
      end
      puts input
    end
  end
end
