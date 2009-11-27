# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestL2Misc <  Test::Unit::TestCase
  def test_convert
    mac = Racket::L2::Misc.long2mac(rand(2**48))
    long = Racket::L2::Misc.mac2long(mac)
    assert_equal(mac, Racket::L2::Misc.long2mac(long))
    assert_equal(long, Racket::L2::Misc.mac2long(mac))
  end
end
# vim: set ts=2 et sw=2:
