# $Id$

module Misc
  # Return a number that is at most size bits long
  def Misc.randbits(size)
    bits = 0
    srand Time.now.usec
    0.upto(size-1) {
      bits <<= 1
      bits |= rand(2)
    }
    bits
  end

  # Return a byte that is at most size bytes long
  def Misc.randbytes(size)
    bytes = 0
    0.upto(size-1) {
      bytes <<= 8
      bytes |= randbits(8)
    }
    bytes
  end

  # Return a string that is at most size characters long
  def Misc.randstring(size)
    s = ""
    0.upto(size-1) {
      s += sprintf("%c", randbytes(1))
    }
    s
  end

  # given a long representing a MAC address
  # print it out in human readable form
  def Misc.macaddr(long)
    long.to_s(16).rjust(12, '0').unpack("a2a2a2a2a2a2").join(":")
  end


end
# vim: set ts=2 et sw=2:
