# frozen_string_literal: true

require 'rspec'

require_relative '../lib/nmax'

RSpec.configure do |config|
  config.expose_dsl_globally = false
end

load_group = lambda do |group|
  Dir["#{__dir__}/#{group}/**/*.rb"].sort.each(&method(:require))
end

%w[helpers shared support].each(&load_group)
