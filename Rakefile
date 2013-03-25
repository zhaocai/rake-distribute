# -*- ruby -*-

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require 'hoe'

# $DEBUG = true

Hoe.plugin :rubygems
Hoe.plugin :git
Hoe.plugin :bundler
Hoe.plugin :test
Hoe.plugin :version

Hoe.spec 'rake-distribute' do
  developer 'Zhao Cai', 'caizhaoff@gmail.com'

  extra_deps << ['diffy', '>= 2.0.9']
end



# vim: syntax=ruby
