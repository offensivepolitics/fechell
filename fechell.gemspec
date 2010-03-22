# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fechell}
  s.version = "0.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Holt"]
  s.date = %q{2010-03-22}
  s.description = %q{Parse electronically filed FEC reports.}
  s.email = %q{jjh@offensivepolitics.net}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["fechell.gemspec", "lib/defs/3.00.csv", "lib/defs/5.00.csv", "lib/defs/5.1.csv", "lib/defs/5.2.csv", "lib/defs/5.3.csv", "lib/defs/6.1.csv", "lib/defs/6.2.csv", "lib/defs/6.3.csv", "lib/defs/6.4.csv", "lib/fechell/forms.rb", "lib/fechell.rb", "lib/tests/f3test.rb", "lib/tests/satest.rb", "lib/tests/sbtest.rb", "lib/tests/sc1test.rb", "lib/tests/sctest.rb", "lib/tests/testdata/F3-3.00-32564-SC1.fec", "lib/tests/testdata/F3-3.00-32777.fec", "lib/tests/testdata/F3-3.00-32909-SC.fec", "lib/tests/testdata/F3-3.00-32933-SB.fec", "lib/tests/testdata/F3-3.00-32933.fec", "lib/tests/testdata/F3-5.00-97348.fec", "lib/tests/testdata/F3-5.00-97424-SB.fec", "lib/tests/testdata/F3-5.00-97424-SC.fec", "lib/tests/testdata/F3-5.00-97424.fec", "lib/tests/testdata/F3-5.00-97986-SC1.fec", "lib/tests/testdata/F3-5.1-116177-SC1.fec", "lib/tests/testdata/F3-5.1-116437-SC2.fec", "lib/tests/testdata/F3-5.1-126642.fec", "lib/tests/testdata/F3-5.1-126655-SB.fec", "lib/tests/testdata/F3-5.1-126655-SC.fec", "lib/tests/testdata/F3-5.1-126655.fec", "lib/tests/testdata/F3-5.2-170434.fec", "lib/tests/testdata/F3-5.2-170443.fec", "lib/tests/testdata/F3-5.2-170775-SC.fec", "lib/tests/testdata/F3-5.2-170890-SC.fec", "lib/tests/testdata/F3-5.2-170890.fec", "lib/tests/testdata/F3-5.2-171146-SC1.fec", "lib/tests/testdata/F3-5.2-171146.fec", "lib/tests/testdata/F3-5.3-210119-SB.fec", "lib/tests/testdata/F3-5.3-210119.fec", "lib/tests/testdata/F3-5.3-210142-SC1.fec", "lib/tests/testdata/F3-5.3-210142.fec", "lib/tests/testdata/F3-5.3-210250.fec", "lib/tests/testdata/F3-5.3-212438-SC.fec", "lib/tests/testdata/F3-6.1-331453-SB.fec", "lib/tests/testdata/F3-6.1-331453.fec", "lib/tests/testdata/F3-6.1-332530-SC.fec", "lib/tests/testdata/F3-6.1-332675.fec", "lib/tests/testdata/F3-6.1-333405-SC1.fec", "lib/tests/testdata/F3-6.1-333405.fec", "lib/tests/testdata/F3-6.2-350353-SC.fec", "lib/tests/testdata/F3-6.2-350353.fec", "lib/tests/testdata/F3-6.2-350775-SB.fec", "lib/tests/testdata/F3-6.2-350775.fec", "lib/tests/testdata/F3-6.2-350844-SC1.fec", "lib/tests/testdata/F3-6.2-350844.fec", "lib/tests/testdata/F3-6.3-413014.fec", "lib/tests/testdata/F3-6.3-413060-SC.fec", "lib/tests/testdata/F3-6.3-413226-SB.fec", "lib/tests/testdata/F3-6.3-413226.fec", "lib/tests/testdata/F3-6.3-413284-SC1.fec", "lib/tests/testdata/F3-6.4-420048-SC.fec", "lib/tests/testdata/F3-6.4-420048.fec", "lib/tests/testdata/F3-6.4-420106.fec", "lib/tests/testdata/F3-6.4-423088-SC1.fec", "lib/tests/testdata/F3-6.4-423088.fec", "lib/tests/testdata/F3-6.4-424094.fec", "lib/tests/testdata/F3-6.4-424586-SB.fec", "lib/tests/testdata/F3-6.4-424586.fec", "lib/tests.rb", "Manifest", "Rakefile", "README.rdoc"]
  s.homepage = %q{http://offensivepolitics.net/fechell}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fechell", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fechell}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Parse electronically filed FEC reports.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fastercsv>, [">= 0"])
    else
      s.add_dependency(%q<fastercsv>, [">= 0"])
    end
  else
    s.add_dependency(%q<fastercsv>, [">= 0"])
  end
end
