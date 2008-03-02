# Internet Group Management Protocol, Version 1
#
# RFC1112 (http://www.faqs.org/rfcs/rfc1112.html)
# 
class IGMPv1 < RacketPart
  # Version (defaults to 1)
  unsigned :version, 4
  # Type
  unsigned :type, 4
  # Unused
  unsigned :unused, 8
  # Checksum
  unsigned :csum, 16
  # Group Address
  octets :gaddr, 32
  # Payload
  rest :payload

  # Check the checksum for this IGMP message
  def checksum?
    self.csum == 0 || (self.csum == compute_checksum)
  end
  
  # Compute and set the checkum for this IGMP message
  def checksum!
    self.csum = compute_checksum
  end

  # Do whatever 'fixing' is neccessary in preparation
  # for being sent
  def fix!
    self.checksum!
  end

private
  def compute_checksum
    # The checksum is the 16-bit one's complement of the one's complement sum
    # of the 8-octet IGMP message.  For computing the checksum, the checksum
    # field is zeroed.
    tmp = []
    tmp << ((((self.version << 4) | self.type) << 8) | self.unused)
    tmp << 0
    tmp << L3::Misc.ipv42long(self.gaddr)
    tmp << self.payload
    L3::Misc.checksum(tmp.pack("nnNa*"))
  end
end
# vim: set ts=2 et sw=2:
