# $Id$

# Internet Group Management Protocol, Version 2: IGMPv2
#
# RFC2236 (http://www.faqs.org/rfcs/rfc2236.html)
class IGMPv2 < RacketPart
  # Type
  unsigned :type, 8
  # Max Response Time
  unsigned :time, 8
  # Checksum
  unsigned :csum, 16
  # Group Address
  octets :gaddr, 32
  # Payload
  rest :payload

  # Is the checksum of this IGMPv2 message correct 
  def checksum?
    self.csum == 0 || (self.csum == compute_checksum)
  end

  # Set the checksum of this IGMPv2 message
  def checksum!
    self.csum = compute_checksum
  end

  # Do whatever 'fixing' is neccessary in preparation
  # for being sent
  def fix!
    checksum!
  end

private
  def compute_checksum
    # The checksum is the 16-bit one's complement of the one's complement sum
    # of the 8-octet IGMP message.  For computing the checksum, the checksum
    # field is zeroed.
    tmp = []
    tmp << ((self.type << 8) | self.time)
    tmp << 0 
    tmp << L3::Misc.ipv42long(self.gaddr)
    tmp << self.payload
    L3::Misc.checksum(tmp.pack("nnNa*"))
  end
end
# vim: set ts=2 et sw=2:
