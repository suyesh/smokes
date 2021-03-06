module Smokes
  # Main Class that runs the cli
  # The Main cli methods are 'new' and 'start'
  class Cli < Thor
    include Thor::Actions
    include Smokes::Utils

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
      empty_directory "#{@name}/smokes"
      template 'templates/main.tt', "#{@name}/main.smoke"
      template 'templates/smokes.tt', "#{@name}/smokes.cfg"
      template 'templates/initial_load.tt', "#{@name}/smokes/initial_load.smoke"
    end

    desc 'start', 'Runs the test suite'
    def start
      check_cfg_file
      check_main_file
      test_selections
      Smokes::Tests.new(@url, @selected_tests, @config_variables).run
    end

    private

    def get_site_title(url)
      @title = Nokogiri::HTML(open(url)).css('title').text
    rescue SocketError
      say("The url you provided doesn\'t seem to be working. Please fix the url at '#{@name}/main.smoke' file".colorize(:red))
      @title = "#We encountered issue verifying '#{@url}'. Please verify it at '#{@name}/main.smoke'"
    end

    def check_cfg_file
      unless File.file?('smokes.cfg')
        say('Generating "smokes.cfg" because it was not found'.colorize(:blue))
        template 'templates/smokes.tt', 'smokes.cfg'
        say('smokes.cfg was successfully generated'.colorize(:grey))
      end
      begin
        @config_variables = TomlRB.load_file('smokes.cfg', symbolize_keys: true)[:defaults]
      rescue StandardError => e
        say("We found 'smokes.cfg' file but were not able to open it. Please verify the file and re-run the tests.")
        puts e
      end
    end

    def check_main_file
      main = File.file?('main.smoke')
      abort("'main.smoke' was not found!!".colorize(:red)) unless main
      load_main_file
    end

    def load_main_file
      @main_file = YAML.load_file('main.smoke')
      @url = @main_file['url']
      @all_tests = @main_file['tests']
    rescue StandardError => error
      puts error
      abort
    end

    def test_selections
      puts "\e[H\e[2J"
      prompt = TTY::Prompt.new active_color: :green
      tests = @all_tests.dup << 'All'
      options = prompt.multi_select "Select tests to run: \n".colorize(:blue), tests
      @selected_tests = options.include?('All') ? @all_tests : options
    end
  end
end
