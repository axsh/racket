# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestL2Misc <  Test::Unit::TestCase
  def test_convert
    (0..rand(1024)).each {
      len = rand(512)+1
      mac = Racket::L2::Misc.randommac(len)
      assert_equal(mac.length, (len*2) + (len-1))
      long = Racket::L2::Misc.mac2long(mac)
      assert_equal(mac, Racket::L2::Misc.long2mac(long, len))
      assert_equal(long, Racket::L2::Misc.mac2long(mac))
      mac = "00:11:22:33:44:55"
      string = Racket::L2::Misc.mac2string(mac)
      assert_equal(mac, Racket::L2::Misc.string2mac(string))
    }
  end
end
# vim: set ts=2 et sw=2:
