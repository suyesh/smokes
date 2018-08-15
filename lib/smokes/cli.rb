module Smokes
  class Cli < Thor
    include Thor::Actions
    no_commands do
      def create_files_and_folders()
        puts ARGV
      end
    end
  end
end
