# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rake-distribute"
  s.version = "1.0.0.20130321034642"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zhao Cai"]
  s.date = "2013-03-21"
  s.description = "generate rake install/uninstall/diff/... tasks to distribute items (files, templates, directories, etc.) to difference locations."
  s.email = ["caizhaoff@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = [".autotest", "Gemfile", "Gemfile.lock", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rake/distribute.rb", "lib/rake/distribute/core.rb", "lib/rake/distribute/dsl.rb", "lib/rake/distribute/error.rb", "lib/rake/distribute/item.rb", "lib/rake/distribute/item/erbfile.rb", "lib/rake/distribute/item/file.rb", "lib/rake/distribute/version.rb", "test/minitest_helper.rb", "test/test_rake_distribute.rb"]
  s.homepage = "https://github.com/zhaocai/rake-distribute"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "zhaowu"
  s.rubygems_version = "1.8.24"
  s.summary = "generate rake install/uninstall/diff/.."
  s.test_files = ["test/test_rake_distribute.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.3"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.3"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.3"])
  end
end
