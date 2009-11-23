# $Id$

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'racket'

class TestLV <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::LV.new(2) }
    assert_nothing_raised() { Racket::LV.new(2,4,1,1,6) }
  end

  def test_decode
    t1 = Racket::LV.new(2)
    s1 = "\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67"
    t1.decode!(s1)
    assert_equal(t1.lengths[0], 11)
    assert_equal(t1.values[0], "spoofed.org")

    t2 = Racket::LV.new(1,2,2,4)
    s2 = "\x02\xab\xcd\x00\x01\xff\x00\x04\xde\xad\xba\xbe\x00\x00\x00\x0a\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffwtf?"
    t2.decode!(s2)
    assert_equal(t2.lengths[0], 2)
    assert_equal(t2.values[0], "\xab\xcd")
    assert_equal(t2.lengths[1], 1)
    assert_equal(t2.values[1], "\xff")
    assert_equal(t2.lengths[2], 4)
    assert_equal(t2.values[2], "\xde\xad\xba\xbe")
    assert_equal(t2.lengths[3], 10)
    assert_equal(t2.values[3], "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff")
    assert_equal(t2.rest, "wtf?")
  end

  def test_encode
    t1 = Racket::LV.new(2)
    s1 = "\x00\x0bspoofed.org"
    t1.decode!(s1)
    assert_equal(t1.encode, s1)
    assert_equal("#{t1}", s1)

    t2 = Racket::LV.new(1,2,2)
    s2 = "\x01\xff\x00\x02\xff\xff\x00\x0bspoofed.org\xff\xff\xffwtf?"
    t2.decode!(s2)
    assert_equal(t2.encode, s2.slice(0, s2.size - 7))
    assert_equal("#{t2}", s2.slice(0, s2.size - 7))

    t3 = Racket::LV.new(1,1,1)
    t3.lengths = [2,2,2]
    t3.values = ["ww", "tt", "ff"]
    assert_equal(t3.encode, "\x02ww\x02tt\x02ff")

    t3 = Racket::LV.new(1,1,1)
    t3.lengths = [2,2,4]
    t3.values = ["ww", "tt", "ff"]
    assert_equal(t3.encode, "\x02ww\x02tt\x04ff\00\00")
  end
end
# vim: set ts=2 et sw=2:
