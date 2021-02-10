# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'auto_html-contrib'
  spec.version       = '0.1.2'
  spec.authors       = ['Dejan Simic']
  spec.email         = ['desimic@gmail.com']

  spec.summary       = 'Filters for `auto_html` gem'
  spec.description   = 'Filters for `auto_html` gem'
  spec.homepage      = 'https://github.com/dejan/auto_html-contrib'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'tag_helper', '~> 0.5'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'fakeweb', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.33'
end
