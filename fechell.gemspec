# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fechell}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Holt"]
  s.date = %q{2009-04-25}
  s.description = %q{Parse electronically filed FEC reports.}
  s.email = %q{jjh@offensivepolitics.net}
  s.extra_rdoc_files = [ "README.rdoc"]
  s.files = ["lib/defs/3.00.csv", "lib/defs/5.00.csv", "lib/defs/5.1.csv", "lib/defs/5.2.csv", "lib/defs/5.3.csv", "lib/defs/6.1.csv", "lib/defs/6.2.csv", "lib/defs/6.3.csv","lib/fechell.rb", "Manifest", "Rakefile", "README.rdoc", "fechell.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://offensivepolitics.net/fechell}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fechell", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fechell}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Parse electronically filed FEC reports.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
