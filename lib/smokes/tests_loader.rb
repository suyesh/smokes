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
      puts @config_variables
      # browser = Selenium::WebDriver.for @config_variables['browser'].to_sym
      # wait = Selenium::WebDriver::Wait.new(timeout: @config_variables['wait_time_out'])
      # browser.get @url
      # input = wait.until do
      #   element = browser.find_element(:name, 'searchbox')
      #   element if element.displayed?
      # end
      # puts input
    end
  end
end
