# frozen_string_literal: true

require_relative 'lib/epcc/version'

Gem::Specification.new do |spec|
  spec.name = 'epcc-ruby'
  spec.version = EPCC::VERSION
  spec.authors = ['Carl Markham']
  spec.email = ['carl.markham@elasticpath.com']

  spec.summary = 'EPCC Ruby SDK'
  spec.description = 'EPCC Ruby SDK'
  spec.homepage = 'https://github.com/cjmarkham/epcc-ruby'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = 'https://github.com/cjmarkham/epcc-ruby'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/cjmarkham/epcc-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/cjmarkham/epcc-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.20'
end
