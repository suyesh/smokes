require 'thor'
require 'colorize'
require 'nokogiri'
require 'open-uri'

module Smokes
  class Cli < Thor
    include Thor::Actions

    def self.source_root
      File.dirname __FILE__
    end

    desc 'new test_project', 'Initialize new test project'
    method_option :url, required: true
    def new(name)
      @url = options[:url]
      @title = Nokogiri::HTML(open(@url)).css('title').text
      empty_directory name
      empty_directory "#{name}/smokes"
      template 'templates/main.tt', "#{name}/main.smoke"
      template 'templates/initial_load.tt', "#{name}/smokes/initial_load.smoke"
    end
  end
end
