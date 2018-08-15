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
      wait = Selenium::WebDriver::Wait.new(:timeout => 15)
      browser.get @url
      puts @selected_tests
      puts @config_variables
    end
  end
end
