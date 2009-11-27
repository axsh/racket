# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestICMP <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::ICMP.new }
    assert_nothing_raised() { Racket::ICMP.new(Racket::Misc.randstring(20)) }
  end

  def test_raw
    binary="\x9e\x96\x00\x35\x00\x0c\x69\x4f\x66\x6f\x6f\x0a"
    assert_nothing_raised() { i = Racket::ICMP.new(binary) }
    i = Racket::ICMP.new(binary)
  end

  def test_build
    i = Racket::ICMP.new
    assert_nothing_raised() {
      i.type = 0
      i.code = 0
      i.fix!
    }
  end
  
end
# vim: set ts=2 et sw=2:
