# $Id$

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'racket/tlv'
require 'test/unit'

class TestTLV <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::TLV.new(2,4) }
  end

  def test_decode
    t = Racket::TLV.new(4,2)
    s = "\x08\x05\x0c\x23\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\xff\x00\xba"
    t.decode!(s)

    assert_equal(t.type, 0x08050c23)
    assert_equal(t.length, 11)
    assert_equal(t.value, "spoofed.org")
    assert_equal(t.rest, "\xff\x00\xba")
  end

  def test_encode
    t = Racket::TLV.new(4,2)
    s = "\x08\x05\x0c\x23\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\xff\xff"
    t.decode!(s)
    assert_equal(t.encode, s.slice(0, s.length - 2))
    assert_equal("#{t}", s.slice(0, s.length - 2))
  end
end
# vim: set ts=2 et sw=2:
