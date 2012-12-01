# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "configuration-blocks"
  s.version = "1.0.0.20121201214825"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pawe\u{142} Wilk"]
  s.cert_chain = ["/Users/siefca/.gem/gem-public_cert.pem"]
  s.date = "2012-12-01"
  s.description = "Easy way of adding configuration blocks to classes, modules and applications."
  s.email = ["pw@gnu.org"]
  s.extra_rdoc_files = ["Manifest.txt"]
  s.files = [".rspec", ".yardopts", "ChangeLog", "LGPL-LICENSE", "Manifest.txt", "README.md", "Rakefile", "docs/COPYING", "docs/HISTORY", "docs/LEGAL", "docs/LGPL-LICENSE", "docs/TODO", "docs/rdoc.css", "docs/yard-tpl/default/fulldoc/html/css/common.css", "configuration-blocks.gemspec", "init.rb", "lib/configuration-blocks.rb", "lib/configuration-blocks/backends.rb", "lib/configuration-blocks/ConfigurationBlocks.rb", "lib/configuration-blocks/core.rb", "lib/configuration-blocks/debug.rb", "lib/configuration-blocks/fallbacks.rb", "lib/configuration-blocks/integration.rb", "lib/configuration-blocks/locales.rb", "lib/configuration-blocks/patches.rb", "lib/configuration-blocks/paths.rb", "lib/configuration-blocks/railtie.rb", "lib/configuration-blocks/resolver.rb", "lib/configuration-blocks/settings.rb", "lib/configuration-blocks/version.rb", "lib/skel/locale.yml"]
  s.homepage = "https://rubygems.org/gems/configuration-blocks/"
  s.rdoc_options = ["--title", "Configuration::Blocks Documentation", "--quiet"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "configuration-blocks"
  s.rubygems_version = "1.8.23"
  s.signing_key = "/Users/siefca/.gem/gem-private_key.pem"
  s.summary = "Easy way of adding configuration blocks to classes, modules and applications"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<yard>, [">= 0.8.2"])
      s.add_development_dependency(%q<rdoc>, [">= 3.8.0"])
      s.add_development_dependency(%q<redcarpet>, [">= 2.1.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.10"])
      s.add_development_dependency(%q<hoe-bundler>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe-gemspec>, [">= 1.0.0"])
      s.add_development_dependency(%q<hoe>, ["~> 2.16"])
    else
      s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<yard>, [">= 0.8.2"])
      s.add_dependency(%q<rdoc>, [">= 3.8.0"])
      s.add_dependency(%q<redcarpet>, [">= 2.1.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.10"])
      s.add_dependency(%q<hoe-bundler>, [">= 1.1.0"])
      s.add_dependency(%q<hoe-gemspec>, [">= 1.0.0"])
      s.add_dependency(%q<hoe>, ["~> 2.16"])
    end
  else
    s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<yard>, [">= 0.8.2"])
    s.add_dependency(%q<rdoc>, [">= 3.8.0"])
    s.add_dependency(%q<redcarpet>, [">= 2.1.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.10"])
    s.add_dependency(%q<hoe-bundler>, [">= 1.1.0"])
    s.add_dependency(%q<hoe-gemspec>, [">= 1.0.0"])
    s.add_dependency(%q<hoe>, ["~> 2.16"])
  end
end
