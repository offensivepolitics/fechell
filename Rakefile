require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('fechell', '0.2.0') do |p|
  p.description    = "Parse electronically filed FEC reports."
  p.url            = "http://offensivepolitics.net/fechell"
  p.author         = "Jason Holt"
  p.email          = "jjh@offensivepolitics.net"
  p.ignore_pattern = ["tmp/*", "script/*", "./Manife*","pkg/*", "doc/*"]
  p.development_dependencies = []
  p.rdoc_pattern = ['README.rdoc']
  p.runtime_dependencies = ['fastercsv']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
