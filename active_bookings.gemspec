# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_bookings/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_bookings'
  spec.version       = ActiveBookings::VERSION
  spec.authors       = ['Jonian Guveli', 'Olibia Tsati']
  spec.email         = ['info@hardpixel.eu']
  spec.summary       = %q{Rails reservation engine that allows bookable resources}
  spec.description   = %q{Make ActiveRecord models bookable with availability rules, schedule etc.}
  spec.homepage      = 'https://github.com/hardpixel/active-bookings'
  spec.license       = 'MIT'
  spec.files         = Dir['{lib/**/*,[A-Z]*}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 5.0'
  spec.add_dependency 'ice_cube', '~> 0.16'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
