# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestICMP <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::L4::ICMP.new }
    assert_nothing_raised() { Racket::L4::ICMP.new(Racket::Misc.randstring(20).force_encoding('BINARY')) }
  end

  def test_raw
    binary="\x9e\x96\x00\x35\x00\x0c\x69\x4f\x66\x6f\x6f\x0a"
    binary="\x08\x00\x05\x7e\xab\x58\x00\x01\x78\xf1\x09\x4b\x00\x00\x00\x00\xce\xe6\x05\x00\x00\x00\x00\x00\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b"
    assert_nothing_raised() { i = Racket::L4::ICMP.new(binary) }
    i = Racket::L4::ICMP.new(binary)
    assert_equal(i.type, 8)
    assert_equal(i.code, 0)
    assert_equal(i.checksum, 0x057e)
    assert_equal(i.payload,
    "\xab\x58\x00\x01\x78\xf1\x09\x4b\x00\x00\x00\x00\xce\xe6\x05\x00\x00\x00\x00\x00\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b\x0c\x0d\x0e\x0f\x0a\x0b")
  end

  def test_build
    i = Racket::L4::ICMP.new
    assert_nothing_raised() {
      i.type = 8
      i.code = 0
      i.payload = "thisisatest"
      i.fix!
    }
    assert_equal(i.checksum, 30152)
  end
  
end
# vim: set ts=2 et sw=2:
