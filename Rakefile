# -*- ruby -*-

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require 'hoe'

# $DEBUG = true


Hoe.plugin :git
Hoe.plugin :gemspec
Hoe.plugin :version
Hoe.plugin :bundler
Hoe.plugin :test

Hoe.spec 'rake-distribute' do
  developer 'Zhao Cai', 'caizhaoff@gmail.com'

  license 'GPL-3'

  extra_deps << ['rake', '>= 10.0.0']
  extra_deps << ['tilt', '>= 1.3.7']
  extra_deps << ['diffy', '>= 2.0.9']
  extra_deps << ['activesupport', '>= 3.2.13']
end


desc "Bump Major Version and Commit"
task "bump:major" => ["version:bump:major"] do
  sh "git commit -am '! Bump version to #{ENV["VERSION"]}'"
end

desc "Bump Minor Version and Commit"
task "bump:minor" => ["version:bump:minor"] do
  sh "git commit -am '* Bump version to #{ENV["VERSION"]}'"
end
desc "Bump Patch Version and Commit"
task "bump:patch" => ["version:bump:patch"] do
  sh "git commit -am 'Bump version to #{ENV["VERSION"]}'"
end


# vim: syntax=ruby
