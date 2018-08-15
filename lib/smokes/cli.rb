require 'thor'
require 'colorize'

module Smokes
  class Cli < Thor
    include Thor::Actions

    desc "Initialize new test", "smokes init new_test_project"
    def init(test)
      empty_directory test
    end
  end
end
