# frozen_string_literal: true

require_relative 'lib/nmax/version'

Gem::Specification.new do |spec|
  spec.name       = 'nmax'
  spec.files      = Dir['lib/**/*.rb']
  spec.executable = 'nmax'
  spec.version    = NMax::VERSION
  spec.authors    = ['Alexander Ilchukov']
  spec.email      = 'alex.ilchukov@gmail.com'
  spec.homepage   = 'https://github.com/venomspawn/funbox-nmax-ruby'
  spec.license    = 'MIT'
  spec.summary    = 'Solution to `nmax` problem from FunBox\'s test case'

  spec.description = <<-DESCRIPTION.tr("\n", ' ').squeeze
    Solution to `nmax` problem from FunBox's test case implemented in Ruby
  DESCRIPTION
end
