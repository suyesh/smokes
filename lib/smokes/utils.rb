module Smokes
  module Utils
    def check_yaml(filename)
      unless YAML.dump(YAML.load_file(filename)) == File.read(filename).gsub(/\s*#.*/, '')
        system('yaml-lint filename')
        abort
       end
       filename
     end
  end
end
