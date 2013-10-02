# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rake-distribute"
  s.version = "1.5.0.20131001222004"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zhao Cai"]
  s.cert_chain = ["/Users/zhaocai/.gem/gem-public_cert.pem"]
  s.date = "2013-10-02"
  s.description = "Generate rake distribute:install, uninstall, and diff tasks to distribute items (files, templates, directories, etc.) to difference locations.\n\nIt is the saver to use rake tasks to manage 1 -> n file distribution. Commonly applied cases are runcom files, Makefiles, etc. Those files exists in many locations and are almost identical with slight difference."
  s.email = ["caizhaoff@gmail.com"]
  s.extra_rdoc_files = ["History.md", "Manifest.txt", "README.md"]
  s.files = [".gemtest", ".vclog", "Gemfile", "Gemfile.lock", "History.md", "Manifest.txt", "README.md", "Rakefile", "lib/rake/distribute.rb", "lib/rake/distribute/core.rb", "lib/rake/distribute/dsl.rb", "lib/rake/distribute/error.rb", "lib/rake/distribute/item.rb", "lib/rake/distribute/item/erbfile.rb", "lib/rake/distribute/item/file.rb", "lib/rake/distribute/item/tiltfile.rb", "lib/rake/distribute/task.rb", "lib/rake/distribute/version.rb", "rake-distribute.gemspec", "test/minitest_helper.rb", "test/test_rake_distribute.rb"]
  s.homepage = "https://github.com/zhaocai/rake-distribute"
  s.licenses = ["GPL-3"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rake-distribute"
  s.rubygems_version = "2.0.3"
  s.signing_key = "/Users/zhaocai/.gem/gem-private_key.pem"
  s.summary = "Generate rake distribute:install, uninstall, and diff tasks to distribute items (files, templates, directories, etc.) to difference locations"
  s.test_files = ["test/test_rake_distribute.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 10.0.0"])
      s.add_runtime_dependency(%q<tilt>, [">= 1.3.7"])
      s.add_runtime_dependency(%q<diffy>, [">= 2.0.9"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, [">= 0"])
      s.add_development_dependency(%q<hoe-gemspec>, [">= 0"])
      s.add_development_dependency(%q<hoe-git>, [">= 0"])
      s.add_development_dependency(%q<hoe-version>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 10.0.0"])
      s.add_dependency(%q<tilt>, [">= 1.3.7"])
      s.add_dependency(%q<diffy>, [">= 2.0.9"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, [">= 0"])
      s.add_dependency(%q<hoe-gemspec>, [">= 0"])
      s.add_dependency(%q<hoe-git>, [">= 0"])
      s.add_dependency(%q<hoe-version>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 10.0.0"])
    s.add_dependency(%q<tilt>, [">= 1.3.7"])
    s.add_dependency(%q<diffy>, [">= 2.0.9"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, [">= 0"])
    s.add_dependency(%q<hoe-gemspec>, [">= 0"])
    s.add_dependency(%q<hoe-git>, [">= 0"])
    s.add_dependency(%q<hoe-version>, [">= 0"])
  end
end
