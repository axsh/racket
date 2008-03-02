# CDP -- Cisco Discovery Protocol
# http://www.cisco.biz/univercd/cc/td/doc/product/lan/trsrb/frames.htm#xtocid12
class CDP < RacketPart
  # CDP Version (generally 1)
  unsigned :version, 8, { :default => 1 }
  # Time-to-live of the data in this message
  unsigned :ttl, 8
  # Checksum
  unsigned :csum, 16
  # Payload of this CDP message.  Generally untouched.
  rest :payload
  
  # Add a new field to this CDP message.
  def add_field(type, value)# {{{
    t = TLV.new(2,2)
    t.type = type
    t.value = value
    t.length = 4 + value.length
    self.payload += t.encode   
  end# }}}

  # Check the checksum for this IP datagram
  def checksum?# {{{
    self.csum == compute_checksum
  end# }}}

  # Compute and set the checksum for this IP datagram
  def checksum!# {{{
    self.csum = compute_checksum
  end# }}}
  
  # Fix this CDP message up for sending.
  def fix!# {{{
    self.checksum!
  end# }}}

private

  # Compute the checksum for this IP datagram
  def compute_checksum# {{{
    pseudo = []
    pseudo << ((self.version << 8) | self.ttl)
    pseudo << 0
    pseudo << self.payload
    L3::Misc.checksum(pseudo.pack("nna*"))
  end# }}}

end
# vim: set ts=2 et sw=2:
