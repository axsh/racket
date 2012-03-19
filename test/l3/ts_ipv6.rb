# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestIPV6 <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::L3::IPv6.new }
    assert_nothing_raised() { Racket::L3::IPv6.new(Racket::Misc.randstring(30)) }
  end

  def test_convert
    long = rand(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
    ipv6 = Racket::L3::Misc.long2ipv6(long)

    assert_equal(long, Racket::L3::Misc.ipv62long(ipv6))
    assert_equal(ipv6, Racket::L3::Misc.long2ipv6(long))
    # assert_nothing_raised { Racket::L3::IPv6.new("a:b:c::1") }
    assert_nothing_raised { Racket::L3::Misc.soll_mcast_addr6(ipv6) }
    mac = Racket::L2::Misc.randommac
    assert_nothing_raised { Racket::L3::Misc.soll_mcast_mac(mac) }
  end
end
# vim: set ts=2 et sw=2:
