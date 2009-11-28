# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestL3Misc <  Test::Unit::TestCase
  def test_checksum

    assert_nothing_raised {
      Racket::L3::Misc.checksum(Racket::Misc.randstring(rand(2048)))
    }
  end
end
# vim: set ts=2 et sw=2:
