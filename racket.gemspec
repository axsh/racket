# $Id$

require 'rubygems'
SPEC = Gem::Specification.new do |s|
  s.name = "racket"
  s.version = "1.0.0"
  s.author = "Jon Hart"
  s.email = "jhart@spoofed.org"
  s.homepage = "http://spoofed.org/files/racket/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Packet foo"
  candidates =  Dir.glob("{bin,docs,examples,lib,test}/**/*")
  s.files = candidates.delete_if do |item|
              item.include?("CVS") || item.include?("rdoc") || item.include?(".svn")
            end
  s.require_path = "lib"
  s.test_files = Dir.glob("test/ts_*.rb")
  s.has_rdoc = true
  s.rdoc_options << "-A rest,octets,hex_octets,unsigned,signed,text,rest"
  s.rdoc_options << "-p"
  s.rdoc_options << "-m" << "README"
  s.rdoc_options << "-W http://code.google.com/p/racket/source/browse/trunk/%s"
  s.extra_rdoc_files = ["README"]
end
# vim: set ts=2 et sw=2:
