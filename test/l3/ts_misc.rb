# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestL3Misc <  Test::Unit::TestCase
  def test_checksum

    assert_nothing_raised {
      Racket::L3::Misc.checksum(Racket::Misc.randstring(rand(2048)))
    }

    mac = "6e:f1:eb:b7:c8:72"
    ll = "fe80::6cf1:ebff:feb7:c872"
    assert_equal(ll, Racket::L3::Misc.linklocaladdr(mac))
  end
end
# vim: set ts=2 et sw=2:
