require 'thor'
require 'colorize'

module Smokes
  class Cli < Thor
    include Thor::Actions

    def self.source_root
      File.dirname __FILE__
    end

    desc 'init new_test_project', 'Initialize new test project'
    def init(name, url)
      opts = {url: url}
      empty_directory name
      empty_directory "#{name}/Tests"
      template 'templates/main.tt', "#{name}/main.yaml", opts
    end
  end
end
