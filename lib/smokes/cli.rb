require 'thor'
require 'colorize'

module Smokes
  class Cli < Thor
    include Thor::Actions

    desc "Initialize new test"
    def init
      empty_directory ARGV[1]
    end
  end
end
