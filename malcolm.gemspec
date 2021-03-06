$:.unshift 'lib'

require 'malcolm/version'

Gem::Specification.new do |s|
  s.name      = 'malcolm'
  s.version   = Malcolm::Version
  s.platform  = Gem::Platform::RUBY
  s.date      = Time.now.strftime('%Y-%m-%d')
  s.summary   = 'A collection of Faraday middleware'
  s.homepage  = 'https://github.com/site5/malcolm'
  s.authors   = ['Floyd Wright']
  s.email     = 'fwright@site5.com'

  s.files     = %w[ Rakefile README.markdown ]
  s.files    += Dir['lib/**/*']
  s.files    += Dir['spec/**/*']

  s.add_runtime_dependency 'faraday', '~> 0.9.0'
  s.add_runtime_dependency 'gyoku', '>= 0.4.4'
  s.add_runtime_dependency 'nori', '>= 1.1.0'
  s.add_runtime_dependency 'nokogiri', '>= 1.6.2.1'

  s.add_development_dependency 'rake', '~> 0.9.2.2'
  s.add_development_dependency 'rspec', '~> 2.10.0'

  s.extra_rdoc_files = ['README.markdown']
  s.rdoc_options     = ["--charset=UTF-8"]

  s.description = <<-DESC
    A collection of Faraday middleware
  DESC
end
