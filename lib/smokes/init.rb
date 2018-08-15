module Smokes
  class Init < Thor::Group
    include Thor::Actions

    def self.source_root
      File.dirname __FILE__
    end

    desc "Initialize New test"
    def setup
      puts ARGV
      empty_directory "wrdgit"
    end
  end
end
