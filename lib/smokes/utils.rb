module Smokes
  module Utils
    def validate_attribute(_test, attribute, name = nil)
      unless _test.key?(attribute)
        puts("#{name || 'Test'} is missing '#{attribute}'".colorize(:red))
        abort
      end
      _test
    end

    def assertion_or_action(assert, action)
      if assert && action
        puts("Cannot have 'assert' and 'action' on same test. Seperate the actions and assertions in seperate tests".colorize(:red))
        abort
      end
      _test
    end
  end
end
