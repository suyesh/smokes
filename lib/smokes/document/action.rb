module Smokes
  module Document
    module Action
      ACTIONS = %w[close execute_async_script execute_script quit].freeze

      def check_action
        @action = @document['action'] if @document.key?('action')
      end

      def initiate_actions
        action = @action.split('=')
        valid_action(action[0])
        if close_or_quit(action)
          run_action(action[0])
        elsif action_requiring_parameter(action)
          run_action_with_param(action)
        end
      end

      def close_or_quit(action)
        action.length == 1 && %w[close quit].include?(action[0])
      end

      def valid_action(action)
        unless ACTIONS.include?(action)
          puts("Invalid Action type for #{@name}\n".colorize(:red))
          abort
        end
      end

      def action_requiring_parameter(action)
        valid = %w[execute_async_script execute_script].include?(action[0]) && (action.length == 2)
        return valid if valid
        unless valid
          puts("'#{action[0].colorize(:red)}' is missing parameter for '#{@name.colorize(:yellow)}'\n".colorize(:red))
          abort
        end
      end

      def run_action_with_param(action)
        binding.pry
        @browser.send(action[0], action[1])
        puts("'#{action[0]}' was successfully performed for '#{@name}'. Passed successfully\n".colorize(:green))
      rescue StandardError
        puts("'#{action[0]}' Could not be performed for '#{@name}'. Failed\n".colorize(:red))
      end

      def run_action(action)
        @browser.send(action)
        puts("'#{action}' was successfully performed for '#{@name}'. Passed successfully\n".colorize(:green))
      rescue StandardError
        puts("'#{action}' Could not be performed for '#{@name}'. Failed\n".colorize(:red))
      end
    end
  end
end
