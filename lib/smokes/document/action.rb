module Smokes
  module Document
    module Action
      ACTIONS = %w[close execute_acync_script execute_script quit].freeze

      def run_actions
        action = @action.split('=')
        valid_action(action[0])
        if close_or_quit(action[0])
          run_action(action[0])
        elsif action_requiring_parameter(action)
          run_action_with_param(action)
        end
      end

      def close_or_quit(action)
        action.length == 1 && %w[close quit].include?(action)
      end

      def valid_action(action)
        unless ACTIONS.include?(action)
          puts("Invalid Action type for #{@name}".colorize(:red))
          abort
        end
      end

      def action_requiring_parameter(action)
        valid = %w[execute_acync_script execute_script].include?(action[0]) && action.length == 2
        unless valid
          puts("#{action[0]} is missing parameter for #{@name}".colorize(:red))
          abort
        end
        valid
      end

      def run_action_with_param(action)
        @browser.send(action[0], action[1])
        puts("#{action[0]} was successfully performed for #{@name}. Passed".colorize(:green))
      rescue StandardError
        puts("#{action[0]} Could not be performed for #{@name}. Failed".colorize(:red))
      end

      def run_action(action)
        @browser.send(action)
        puts("#{action} was successfully performed for #{@name}. Passed".colorize(:green))
      rescue StandardError
        puts("#{action} Could not be performed for #{@name}. Failed".colorize(:red))
      end
    end
  end
end
