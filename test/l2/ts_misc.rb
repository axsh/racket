# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestL2Misc <  Test::Unit::TestCase
  def test_convert
    len = rand(32)
    mac = Racket::L2::Misc.randommac(len)
    long = Racket::L2::Misc.mac2long(mac)
    assert_equal(mac, Racket::L2::Misc.long2mac(long, len))
    assert_equal(long, Racket::L2::Misc.mac2long(mac))
  end
end
# vim: set ts=2 et sw=2:
