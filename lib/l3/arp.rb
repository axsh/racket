# Address Resolution Protocol: ARP
#
# RFC826 (http://www.faqs.org/rfcs/rfc826.html)
class ARP < RacketPart
  ARPOP_REQUEST = 0x0001
  ARPOP_REPLY = 0x0002
  
  # Hardware type 
  unsigned :htype, 16, { :default => 1 }
  # Protocol type 
  unsigned :ptype, 16, { :default => 0x0800 }
  # Hardware address length
  unsigned :hlen, 8, { :default => 6 }
  # Protocol address length
  unsigned :plen, 8, { :default => 4 }
  # Opcode
  unsigned :opcode, 16
  # XXX: This is not entirely correct.  Technically, sha, spa, tha and
  # tpa should be sized according to hlen and plen.  This is good enough for
  # Ethernet and IPv4.

  # Source hardware address
  hex_octets :sha, 48
  # Source protocol address
  octets :spa, 32
  # Target hardware address
  hex_octets :tha, 48
  # Target protcol address
  octets :tpa, 32
  # Payload
  rest :payload
end
# vim: set ts=2 et sw=2:
