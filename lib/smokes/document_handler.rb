module Smokes
  # Runs for Document Test
  class DocumentHandler
    ACTIONS = %w[close execute_acync_script execute_script quit].freeze
    ASSERT  = %w[current_url visible? title].freeze

    def initialize(_test, browser, wait)
      @pastel = Pastel.new
      @browser = browser
      @wait = wait
      @test = test
    end

    def run
      parse_attributes
    end

    private

    def parse_attributes
      name
      document
      check_action
      validate_assert
      validate_assertion
      run_assertion
    end

    def name
      @name = validate_attribute(@test, 'name')['name']
    end

    def document
      @document = validate_attribute(@test, 'document', @name)['document']
    end

    def validate_attribute(test, attribute, name = nil)
      unless test.key?(attribute)
        @pastel.white.on_red.bold("#{name || 'Test'} is missing '#{attribute}'")
        abort
      end
      test
    end

    def validate_assertion
      if invalid_assertions || !ASSERT.include?(assertions[0])
        @pastel.white.on_red.bold("Invalid Assertion for #{@name}")
        abort
      end
      @target = assertion[0]
      @assertion = assertion[1]
    end

    def run_assertion
      result = @browser.send(@target)
      if result == @assertion
        @pastel.white.on_green.bold("#{@name} Passed successfully. ")
      else
        @pastel.white.on_red.bold("#{@name} Failed. ")
      end
    rescue StandardError
      puts "Something went wrong while running the test #{@name}".colorize(:red)
    end

    def validate_assert
      @assert = validate_attribute(@document, 'assert', @name)['assert']
    end

    def invalid_assertion
      assertions.length != 2
    end

    def assertions
      @assert.split('=')
    end

    def check_action
      if @document.key?('action')
        @action = @document.key?('action')
        run_actions
      end
    end

    def run_actions
      action = @action.split('=')
      valid_action(action)
      if !close_or_quit(action[0])
        @pastel.white.on_red.bold("#{action[0]} is not a valid action for #{@name}")
        abort
      elsif close_or_quit(action[0])
        begin
          @browser.send(action[0])
          @pastel.white.on_green.bold("#{action[0]} was successfully performed for #{@name}. Passed")
        rescue StandardError
          @pastel.white.on_red.bold("#{action[0]} Could not be performed for #{@name}. Failed")
        end
      elsif action_requiring_parameter(action)
        begin
         @browser.send(action[0], action[1])
         @pastel.white.on_green.bold("#{action[0]} was successfully performed for #{@name}. Passed")
       rescue StandardError
         @pastel.white.on_red.bold("#{action[0]} Could not be performed for #{@name}. Failed")
       end
      end
    end

    def close_or_quit(action)
      action.length == 1 && %w[close quit].include?(action)
    end

    def valid_action(action)
      unless ACTIONS.include?(action)
        @pastel.white.on_red.bold("Invalid Action type for #{@name}")
        abort
      end
    end

    def action_requiring_parameter(action)
      valid = %w[execute_acync_script execute_script].include?(action[0]) && action.length != 2
      unless valid
        @pastel.white.on_red.bold("#{action[0]} is missing parameter for #{@name}. Failed")
        abort
      end
      valid
    end
  end
end
