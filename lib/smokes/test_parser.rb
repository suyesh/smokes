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
          say("#{test['name']}. PASSED".colorize(:green))
        else
          say("#{test['name']}. FAILED".colorize(:red))
        end
      else
        say('Your test is missing value'.colorize(:red))
        puts test
        abort
      end
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
