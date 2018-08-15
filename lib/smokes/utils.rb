module Smokes
  module Utils
    def check_yaml(filename)
      unless YAML.dump(YAML.load_file(filename)) == File.read(filename).gsub(/\s*#.*/, '')
        output = []
        r, io = IO.pipe
        fork do
          system('yaml-lint filename', out: io, err: :out)
        end
        io.close
        r.each_line{|l| puts l; output << l.chomp}
        abort
       end
       filename
     end

     def test_hello
       puts "HELLO"
     end
  end
end
