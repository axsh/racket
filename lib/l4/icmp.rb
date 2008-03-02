# Internet Control Message Protcol.  
#
# RFC792 (http://www.faqs.org/rfcs/rfc792.html)
class ICMP < RacketPart
  ICMP_TYPE_ECHO_REPLY = 0
  ICMP_TYPE_DESTINATION_UNREACHABLE = 3
  ICMP_TYPE_SOURCE_QUENCH = 4
  ICMP_TYPE_REDIRECT = 5
  ICMP_TYPE_ECHO_REQUEST = 8 
  ICMP_TYPE_MOBILE_IP_ADVERTISEMENT = 9
  ICMP_TYPE_ROUTER_SOLICITATION = 10
  ICMP_TYPE_TIME_EXCEEDED = 11
  ICMP_TYPE_PARAMETER_PROBLEM = 12
  ICMP_TYPE_TIMESTAMP_REQUEST = 13
  ICMP_TYPE_TIMESTAMP_REPLY = 14
  ICMP_TYPE_INFO_REQUEST = 15
  ICMP_TYPE_INFO_REPLY = 16
  ICMP_TYPE_ADDRESS_MASK_REQUEST = 17
  ICMP_TYPE_ADDRESS_MASK_REPLY = 18

  # Type
  unsigned :type, 8
  # Code
  unsigned :code, 8
  # Checksum
  unsigned :csum, 16
  # ID
  unsigned :id, 16
  # Sequence number
  unsigned :seq, 16
  # Payload
  rest :payload

  # check the checksum for this ICMP packet
  def checksum?
    self.csum == compute_checksum
  end

  # compute and set the checksum for this ICMP packet
  def checksum!
    self.csum = compute_checksum
  end

  # 'fix' this ICMP packet up for sending.
  # (really, just set the checksum)
  def fix!
    self.checksum!
  end

private
  def compute_checksum
    # pseudo header used for checksum calculation as per RFC 768 
    pseudo = [ self.type, self.code, 0,  self.id, self.seq, self.payload ]
    L3::Misc.checksum(pseudo.pack("CCnnna*"))
  end
end

# vim: set ts=2 et sw=2:
