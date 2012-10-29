# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rake-distribute"
  s.version = "0.1.0.20121026002333"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zhao Cai"]
  s.date = "2012-10-26"
  s.description = ""
  s.email = ["caizhaoff@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = [".autotest", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rake/distribute.rb", "lib/rake/distribute/core.rb", "lib/rake/distribute/dsl.rb", "lib/rake/distribute/item.rb", "lib/rake/distribute/version.rb", "test/unittest.rb", "test/test_rake_distribute.rb", ".gemtest"]
  s.homepage = "https://github.com/zhaocai/hoe-distribute"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rake-distribute"
  s.rubygems_version = "1.8.24"
  s.summary = ""
  s.test_files = ["test/test_rake_distribute.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.1"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.1"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.1"])
  end
end
