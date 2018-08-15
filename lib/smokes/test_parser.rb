module Smokes
  # Parses individual test and runs it using selenium
  class TestParser
    def initialize(filename, selenium_browser, selenium_wait)
      @filename = filename
      @test = YAML.load_file(filename)
      @selenium_browser = selenium_browser
      @selenium_wait = selenium_wait
    end

    def run
      @test.each do |test|
        if test.key?('test')
          document_test(test) if test['test']['document']
          element_test(test) if test['test']['element']
        else
          say("your test is missing the test attribute: #{filename}")
          abort
        end
      end
    end

    private

    def document_test(test)
      if test['name'] && test['test']['document']['title'] && test['test']['document']['title']['should_be']
        assertion = @selenium_browser.title == test['test']['document']['title']['should_be']
        if assertion
          puts("#{test['name']}. PASSED".colorize(:green))
        else
          puts("#{test['name']}. FAILED".colorize(:red))
          puts("=====> Expected: #{test['test']['document']['title']['should_be']}".colorize(:yellow))
          puts("=====> Found: #{@selenium_browser.title}".colorize(:yellow))
        end
      else
        puts('Your test is missing value'.colorize(:red))
        puts test
        abort
      end
   end

   def element_test(test)
     if test['name'] && (valid_element_test(test))
       puts test
#        wait.until {
#     element = browser.find_element(:name, "input")
#     element if element.displayed?
# }
     end
   end

   def valid_element_test(test)
     test['test']['element']['xpath'] ||
     test['test']['element']['class_name'] ||
     test['test']['element']['css'] ||
     test['test']['element']['id'] ||
     test['test']['element']['link'] ||
     test['test']['element']['link_text'] ||
     test['test']['element']['name'] ||
     test['test']['element']['partial_link_text'] ||
     test['test']['element']['tag_name']
   end
 end
end

# {
# :class => 'ClassName',
# :class_name => 'ClassName',
# :css => 'CssSelector',
# :id => 'Id',
# :link => 'LinkText',
# :link_text => 'LinkText',
# :name => 'Name',
# :partial_link_text => 'PartialLinkText',
# :tag_name => 'TagName',
# :xpath => 'Xpath',
# }
