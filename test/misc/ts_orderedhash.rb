# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestBitField <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::Misc::OrderedHash.new }
  end
  def test_order
    oh = Racket::Misc::OrderedHash.new
    ("a".."z").each { |c|
        oh[c] = c.unpack("c")[0]
    } 

    97.upto(122) { |v| 
      assert_equal(oh[sprintf("%c", v)], v)      
    } 

    assert_nil(oh['kajf'])
    
    copy = []
    oh.each_key { |k| copy << k }
    0.upto(25) { |v|
      assert_equal(copy[v], sprintf("%c", 97 + v))
    }

    assert_nil(copy[205])
  end
end
# vim: set ts=2 et sw=2:
