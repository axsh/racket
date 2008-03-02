# $Id$

#     XXX: currently broken.  all of the "optional" fields must be made dynamic
class GRE < RacketPart
  # Is a checksum present?
  unsigned :checksum_present, 1
  # Is routing information present?
  unsigned :routing_present, 1
  # Is a key present?
  unsigned :key_present, 1
  # Is a sequence number present?
  unsigned :seq_present, 1
  # Strict source route
  unsigned :ssr, 1
  # How many additional encapsulations are present?
  unsigned :recursion, 3
  # Flags
  unsigned :flags, 5
  # Version
  unsigned :version, 3
  # Protocol type
  unsigned :protocol, 16
  # Checksum
  unsigned :checksum, 16
  # Offset
  unsigned :offset, 16
  # Key
  unsigned :key, 32
  # Sequence Number
  unsigned :seq, 32
  # Routing
  unsigned :routing, 32
  # Payload
  rest :payload
end
# vim: set ts=2 et sw=2:
