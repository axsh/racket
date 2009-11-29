# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestIPv4 <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::L3::IPv4.new }
    assert_nothing_raised() { Racket::L3::IPv4.new(Racket::Misc.randstring(30)) }
  end

  def test_attrs
    binary = "\x45\x10\x00\x3c\x2f\xdf\x40\x00\x40\x06\x89\x17\xc0\xa8\x00\x64\xc0\xa8\x00\x01\x99\xb7\x00\x35\x29\x39\x28\x66\x00\x00\x00\x00\xa0\x02\x16\xd0\xbc\x04\x00\x00\x02\x04\x05\xb4\x04\x02\x08\x0a\x00\x31\x07\xb9\x00\x00\x00\x00\x01\x03\x03\x07"
    i = Racket::L3::IPv4.new(binary)
    assert_equal(i.version, 4)
    assert_equal(i.hlen, 5)
    assert_equal(i.tos, 16)
    assert_equal(i.len, 60)
    assert_equal(i.id, 12255)
    assert_equal(i.flags, 2)
    assert_equal(i.foffset, 0)
    assert_equal(i.ttl, 64)
    assert_equal(i.protocol, 6)
    assert_equal(i.checksum, 35095)
    assert_equal(i.src_ip, "192.168.0.100")
    assert_equal(i.dst_ip, "192.168.0.1")

    i.src_ip = "1.2.3.4"
    i.fix!
    assert_equal(i.checksum, 17950)
  end

  def test_convert
    (0..512).each {
      long = rand(2**32)
      ipv4 = Racket::L3::Misc.long2ipv4(long)
      assert_equal(long, Racket::L3::Misc.ipv42long(ipv4))
      assert_equal(ipv4, Racket::L3::Misc.long2ipv4(long))
    }
  end
end
# vim: set ts=2 et sw=2:
