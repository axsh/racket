# $Id$

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'vt'
require 'test/unit'

class TestVT <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { VT.new(2) }
    assert_nothing_raised() { VT.new(2,4,4,4,4,4,12,3) }
  end

  def test_decode
    s1 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\xab\xcd\xef"
    t1 = VT.new
    t1.decode!(s1)
    assert_equal(t1.value, "spoofed.org")
    assert_equal(t1.types.size, 0)
    assert_equal(t1.rest, "\x01\x02\x03\x04\xab\xcd\xef")

    t2 = VT.new(4)
    s2 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04"
    t2.decode!(s2)

    assert_equal(t2.types[0], 0x01020304)
    assert_equal(t2.value, "spoofed.org")
    assert_equal(t2.rest, "")

    t3 = VT.new(1,2,2,4)
    s3 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\x05\xde\xad\xba\xbe\x11\xff"
    t3.decode!(s3)

    assert_equal(t3.types[0], 0x01)
    assert_equal(t3.types[1], 0x0203)
    assert_equal(t3.types[2], 0x0405)
    assert_equal(t3.types[3], 0xdeadbabe)
    assert_equal(t3.value, "spoofed.org")
    assert_equal(t3.rest, "\x11\xff")
  end

  def test_encode
    t1 = VT.new(4)
    s1 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04"
    t1.decode!(s1)
    assert_equal(t1.encode, s1)
    assert_equal("#{t1}", s1)

    t2 = VT.new(1,2,2,4)
    s2 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\x05\xde\xad\xba\xbe\xff\xff"
    t2.decode!(s2)
    assert_equal(t2.encode, s2.slice(0, s2.size - 2))
    assert_equal("#{t2}", s2.slice(0, s2.size - 2))
  end
end
# vim: set ts=2 et sw=2:
