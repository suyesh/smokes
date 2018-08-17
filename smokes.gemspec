lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smokes/version'

Gem::Specification.new do |spec|
  spec.name          = 'smokes'
  spec.version       = Smokes::VERSION
  spec.authors       = ['Suyesh Bhandari']
  spec.email         = ['suyeshb@gmail.com']

  spec.summary       = 'Easy to use selenium wrapper (Just a placeholder. Not ready yet.)'
  spec.description   = 'Easy to use selenium wrapper (Just a placeholder. Not ready yet.)'
  spec.homepage      = 'https://github.com'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'os'
  spec.add_dependency 'selenium-webdriver'
  spec.add_dependency 'thor'
  spec.add_dependency 'toml-rb'
  spec.add_dependency 'tty-prompt'
  spec.add_dependency 'tty-table'
  spec.add_dependency 'yaml-lint'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
