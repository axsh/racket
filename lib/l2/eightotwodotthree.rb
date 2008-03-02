# $Id$

# 802.3 Ethernet.  Should always be followed by an LLC header
class EightOTwoDotThree < RacketPart
  # Destination MAC address
  hex_octets :dst_mac, 48
  # Source MAC address
  hex_octets :src_mac, 48
  # Length of the payload 
  unsigned :length, 16
  # Payload
  rest :payload

  # Fix this layer up prior to sending.  For 802.3, just adjusts +length+
  def fix!
    self.length = self.payload.length
  end
end
# vim: set ts=2 et sw=2:
