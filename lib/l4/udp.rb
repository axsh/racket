# User Datagram Protocol: UDP
#
# RFC768 (http://www.faqs.org/rfcs/rfc768.html)
class UDP < RacketPart
  # Source Port
  unsigned :src_port, 16
  # Destination Port
  unsigned :dst_port, 16
  # Datagram Length
  unsigned :len, 16
  # Checksum
  unsigned :csum, 16
  # Payload
  rest :payload
  
  # Check the checksum for this UDP datagram
  def checksum?(src_ip, dst_ip)
    self.csum == 0 || (self.csum == compute_checksum(src_ip, dst_ip))
  end

  # Compute and set the checksum for this UDP datagram
  def checksum!(src_ip, dst_ip)
    # set the checksum to 0 for usage in the pseudo header...
    self.csum = 0
    self.csum = compute_checksum(src_ip, dst_ip)
  end

  # Fix this packet up for proper sending.  Sets the length
  # and checksum properly.
  def fix!(src_ip, dst_ip)
    self.len = self.class.bit_length/8 + self.payload.length
    self.checksum!(src_ip, dst_ip)
  end

  def initialize(*args)
    super
    @autofix = false
  end 

private
  # Compute the checksum for this UDP datagram
  def compute_checksum(src_ip, dst_ip)
    # pseudo header used for checksum calculation as per RFC 768 
    pseudo = [L3::Misc.ipv42long(src_ip), L3::Misc.ipv42long(dst_ip), 17, self.payload.length + self.class.bit_length/8 ]
    header = [self.src_port, self.dst_port, self.payload.length + self.class.bit_length/8, 0, self.payload]
    L3::Misc.checksum((pseudo << header).flatten.pack("NNnnnnnna*"))
  end

end
# vim: set ts=2 et sw=2:
