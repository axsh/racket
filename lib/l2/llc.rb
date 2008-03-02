# Logical Link Control (http://en.wikipedia.org/wiki/Logical_Link_Control)
class LLC < RacketPart
  LLC_IBM_SNA = 0x04 
  LLC_IP = 0x06
  LLC_3COM = 0x80
  LLC_SNAP = 0xAA
  LLC_BANYAN = 0xBC
  LLC_NOVELL = 0xE0
  LLC_LANMAN = 0xF4
  # Destination Service Access Point address
  unsigned :dsap, 8, { :default => 0xaa }
  # Source Service Access Point address
  unsigned :ssap, 8, { :default => 0xaa }
  # Control field
  unsigned :control, 8
  # Payload
  rest :payload
end
# vim: set ts=2 et sw=2:
