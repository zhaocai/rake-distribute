# -*- ruby -*-

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require 'hoe'

# $DEBUG = true


Hoe.plugin :git
Hoe.plugin :gemspec
Hoe.plugin :version
Hoe.plugin :bundler

Hoe.spec 'rake-distribute' do
  developer 'Zhao Cai', 'caizhaoff@gmail.com'

  license 'GPL-3'

  extra_deps << ['rake', '>= 10.0.0']
  extra_deps << ['tilt', '>= 1.3.7']
  extra_deps << ['diffy', '>= 2.0.9']
  extra_deps << ['activesupport', '>= 3.2.13']
end

%w{major minor patch}.each { |v|
  desc "Bump #{v.capitalize} Version"
  task "bump:#{v}", [:message] => ["version:bump:#{v}"] do |t, args|
    m = args[:message] ? args[:message] : "Bump version to #{ENV["VERSION"]}"
    sh "git commit -am '#{m}'"
  end
}


# vim: syntax=ruby
