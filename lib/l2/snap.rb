# Subnetwork Access Protocl (http://en.wikipedia.org/wiki/Subnetwork_Access_Protocol)
class SNAP < RacketPart
  # Organizational code
  unsigned :org, 24, { :default => 0x00000c }
  # Protocol ID
  unsigned :pid, 16
  rest :payload
end
# vim: set ts=2 et sw=2:
