# $Id$

$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require 'test/unit'
require 'racket'

class TestTCP <  Test::Unit::TestCase
  def test_init
    assert_nothing_raised() { Racket::TCP.new }
    assert_nothing_raised() { Racket::TCP.new(Racket::Misc.randstring(20)) }
  end

  def test_attrs
    binary="\x90\xef\x08\xae\x47\x87\xa0\x34\x00\x00\x00\x00\xa0\x02\x16\xd0\xc2\x17\x00\x00\x02\x04\x05\xb4\x04\x02\x08\x0a\x03\x0f\xc8\x6e\x00\x00\x00\x00\x01\x03\x03\x07"
   
    assert_nothing_raised() { i = Racket::TCP.new(binary) }
    i = Racket::TCP.new(binary)
    assert_equal(i.dst_port, 2222)
    assert_equal(i.src_port, 37103)
    assert_equal(i.flag_syn, 1)
    assert_equal(i.flag_ack, 0)
    assert_equal(i.seq, 0x4787a034)
    assert_equal(i.ack, 0)
    assert_equal(i.window, 5840)
    assert_equal(i.checksum, 0xc217)
    assert_equal(i.payload,
    "\x02\x04\x05\xb4\x04\x02\x08\x0a\x03\x0f\xc8\x6e\x00\x00\x00\x00\x01\x03\x03\x07")

  end

  def test_build_no_options
    i = Racket::TCP.new
    assert_nothing_raised() {
      i.src_port = 44781 
      i.dst_port = 5190 
      i.seq = 0x4e3e537a
      i.ack = 0xbdca7ef8
      i.flag_ack = 1
      i.flag_psh = 1
      i.offset = 5
      i.window = 61200
      i.payload = "\x2a\x05\x0b\xca\x00\x00"
    }

    i.checksum!("192.168.1.10", "64.12.26.128")
    assert_equal(i.checksum, 0xccf8)
  end
  
  def test_build_with_options
    i = Racket::TCP.new
    i.add_option(1, "blah")
  end
end
# vim: set ts=2 et sw=2:
