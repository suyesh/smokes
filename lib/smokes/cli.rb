require 'thor'
require 'colorize'

module Smokes
  class Cli < Thor
    include Thor::Actions

    def self.source_root
      File.dirname __FILE__
    end

    option :url
    desc 'smokes init new_test_project', 'Initialize new test project'
    def init(name)
      empty_directory name
      empty_directory "#{name}/Tests"
      create_file "#{name}/main.yaml"
    end
  end
end
