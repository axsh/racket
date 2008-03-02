# $Id$

# Internet Protocol Version 6 (IPV6)
# RFC2460
# XXX: not tested, incomplete.
class IPv6 < RacketPart
  # IP Version (defaults to 6)
  unsigned :version, 4, { :default => 6 }
  # Traffic class
  unsigned :tclass, 8
  # Flow label
  unsigned :flow, 20
  # Payload lenght
  unsigned :plen, 16
  # Next header type
  unsigned :nhead, 8
  # Hop limit
  unsigned :ttl, 8
  # Source IP address
  unsigned :src_ip, 128
  # Destination IP address
  unsigned :dst_ip, 128
  # Payload
  rest :payload
end
# vim: set ts=2 et sw=2:
