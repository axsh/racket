# $Id$

# Hot Standby Router Protocol: HSRP
#
# RFC2281 (http://www.faqs.org/rfcs/rfc2281.html)
class HSRP < RacketPart
  HSRP_HELLO = 0
  HSRP_COUP = 1
  HSRP_RESIGN = 2

  HSRP_INITIAL = 0
  HSRP_LEARN   = 1 
  HSRP_LISTEN  = 2 
  HSRP_SPEAK   = 4 
  HSRP_STANDBY = 8
  HSRP_ACTIVE  = 16

  # Version of the HSRP message contained in this packet.  Defaults to 0
  unsigned :version, 8
  # Type of the HSRP message contained in this packet.
  unsigned :opcode, 8
  # Current state of the router sending the message
  unsigned :state, 8
  # Time between the hello messages that this router sends.  Obviously only 
  # useful in hello messages
  unsigned :hellotime, 8
  # Length of time that this hello message should be considered valid.
  # Obviously only useful in hello messages.
  unsigned :holdtime, 8, { :default => 10 }
  # Priority used to determine active and standby routers.  Higher priorities
  # win, but a higher IP address wins in the event of a tie.
  unsigned :priority, 8
  # Standby group
  unsigned :group, 8
  unsigned :reserved, 8
  # Clear-text, 8-character reused password.  Defaults to 'cisco'
  text :password, 64, { :default => 'cisco' }
  # Virtual IP address used by this group
  octets :vip, 32
  # Payload.  Generally unused.
  rest :payload
end
# vim: set ts=2 et sw=2:
