module Smokes
  def check_yaml(filename)
    unless YAML.dump(YAML.load_file(filename)) == File.read(filename).gsub(/\s*#.*/, '')
      %x( yaml-lint filename )
      abort
    end
  end
end
