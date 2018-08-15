require 'thor'
require 'colorize'
require 'nokogiri'

module Smokes
  class Cli < Thor
    include Thor::Actions

    def self.source_root
      File.dirname __FILE__
    end

    desc 'init new_test_project', 'Initialize new test project'
    method_option :url, required: true
    def init(name)
      @url = options[:url]
      empty_directory name
      empty_directory "#{name}/smokes"
      template 'templates/main.tt', "#{name}/main.yaml"
      open(@url) do |f|
        doc = Nokogiri::HTML(f)
        @title = doc.at_css('title').text
      end
      template 'templates/initial_load.tt', "#{name}/smokes/initial_load.yaml"
    end
  end
end
