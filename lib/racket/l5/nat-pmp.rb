module Racket
module L5
# Network Address Translation Port Mapping Protocol (NAT-PMP)  
#  
# (http://tools.ietf.org/html/draft-cheshire-nat-pmp-03)
#
# Generic NAT-PMP which all NAT-PMP variants spawn.  This should never be used directly.
class NATPMPGeneric < RacketPart
  # Version
  unsigned :version, 8
  # Opcode 
  unsigned :opcode, 8
  rest :message

  def initialize(*args)
    super(*args)
  end
end

# Send raw NATPMP packets of your own design
class NATPMP < NATPMPGeneric
  rest :payload
end

# NATPMP 
class NATPMPMappingRequest < NATPMPGeneric
  unsigned :reserved, 16
  unsigned :internal_port, 16
  unsigned :external_port, 16
  unsigned :lifetime, 32
  rest :payload

  def initialize(*args)
    super(*args)
    self.version = 0
    self.opcode = 1
  end
end
end
end
## vim: set ts=2 et sw=2:
