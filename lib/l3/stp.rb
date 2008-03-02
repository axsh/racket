# $Id$

# Spanning Tree Protocol
#
# http://en.wikipedia.org/wiki/Spanning_tree_protocol
class STP < RacketPart
  # Protocol identifier
  unsigned :protocol, 16, { :default => 0 }
  # Protocol version 
  unsigned :version, 8, { :default => 2}
  # BPDU type
  unsigned :bpdu_type, 8, { :default => 2 }
  # BPDU Flag -- Topology Change Acknowledgement
  unsigned :bpdu_flag_change_ack, 1
  # BPDU Flag -- Agreement
  unsigned :bpdu_flag_agreement, 1
  # BPDU Flag -- Forwarding
  unsigned :bpdu_flag_forwarding, 1
  # BPDU Flag -- Learning
  unsigned :bpdu_flag_learning, 1
  # BPDU Flag -- Port Role
  unsigned :bpdu_flag_port_role, 2
  # BPDU Flag -- Proposal
  unsigned :bpdu_flag_proposal, 1
  # BPDU Flag -- Topology Change
  unsigned :bpdu_flag_change, 1
  # Root wtf?  Not sure what this is XXX
  unsigned :root_wtf, 16
  # Root Identifier
  hex_octets :root_id, 48
  # Root Path Cost
  unsigned :root_cost, 32
  # Bridge WTF? Not sure what this is XXX
  unsigned :bridge_wtf, 16
  # Bridge Identifier
  hex_octets :bridge_id, 48
  # Port Identifier
  unsigned :port_id, 16
  # Message age
  unsigned :msg_age, 16
  # Max age
  unsigned :max_age, 16
  # Hello time
  unsigned :hello_time, 16
  # Forward delay
  unsigned :forward_delay, 16
  # Version 1 Length
  unsigned :v1_len, 8
  # Payload
  rest :payload
end
# vim: set ts=2 et sw=2:
