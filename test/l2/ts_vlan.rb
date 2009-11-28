# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestVLAN <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::VLAN.new }
    assert_nothing_raised() { Racket::VLAN.new(Racket::Misc.randstring(30)) }
  end

end
# vim: set ts=2 et sw=2:
