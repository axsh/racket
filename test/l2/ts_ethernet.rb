# $Id$

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'racket'

class TestEthernet <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::Ethernet.new }
    assert_nothing_raised() { Racket::Ethernet.new(Racket::Misc.randstring(30)) }
  end

  def test_attrs
    binary = "\x00\x00\x24\xc1\x8c\x09\x00\x30\x1b\xa0\x63\x16\x08\x00\x45\x10\x00\x3c\x2f\xdf\x40\x00\x40\x06\x89\x17\xc0\xa8\x00\x64\xc0\xa8\x00\x01\x99\xb7\x00\x35\x29\x39\x28\x66\x00\x00\x00\x00\xa0\x02\x16\xd0\xbc\x04\x00\x00\x02\x04\x05\xb4\x04\x02\x08\x0a\x00\x31\x07\xb9\x00\x00\x00\x00\x01\x03\x03\x07"
    e = Racket::Ethernet.new(binary)
    assert_equal(e.src_mac, "00:30:1b:a0:63:16")
    assert_equal(e.dst_mac, "00:00:24:c1:8c:09")
    assert_equal(e.ethertype, 2048)
  end
end
# vim: set ts=2 et sw=2:
