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
      @name = name
      @url = options[:url]
      get_site_title(@url)
      empty_directory name
      empty_directory "#{name}/smokes"
      template 'templates/main.tt', "#{name}/main.smoke"
      template 'templates/initial_load.tt', "#{name}/smokes/initial_load.smoke"
    end

    private

    def get_site_title(url)
      @title = Nokogiri::HTML(open(url)).css('title').text
    rescue SocketError
      say("The url you provided doesn\'t seem to be working. Please fix the url at '#{@name}/main.smoke' file".colorize(:red))
      @title = "#We encountered issue verifying '#{@url}'. Please verify it at '#{@name}/main.smoke'"
    end
  end
end
