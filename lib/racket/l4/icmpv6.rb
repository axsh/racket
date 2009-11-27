# $Id$
#
# Copyright (c) 2008, Jon Hart 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the <organization> nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY Jon Hart ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Jon Hart BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
module Racket
# Internet Control Message Protcol, v6
#
# http://en.wikipedia.org/wiki/ICMPv6
#
# Generic ICMP class from which all ICMP variants spawn.  This should never be used directly.
class ICMPv6Generic < RacketPart
  ICMPv6_TYPE_ECHO_REPLY = 129
  ICMPv6_TYPE_DESTINATION_UNREACHABLE = 1
  ICMPv6_TYPE_PACKET_TOO_BIG = 2
#  ICMPv6_TYPE_SOURCE_QUENCH = 
#  ICMPv6_TYPE_REDIRECT = 
  ICMPv6_TYPE_ECHO_REQUEST = 128
#  ICMPv6_TYPE_MOBILE_IP_ADVERTISEMENT = 
#  ICMPv6_TYPE_ROUTER_SOLICITATION = 
  ICMPv6_TYPE_TIME_EXCEEDED = 3
  ICMPv6_TYPE_PARAMETER_PROBLEM = 4
#  ICMPv6_TYPE_TIMESTAMP_REQUEST = 
#  ICMPv6_TYPE_TIMESTAMP_REPLY = 
#  ICMPv6_TYPE_INFO_REQUEST = 
#  ICMPv6_TYPE_INFO_REPLY = 
#  ICMPv6_TYPE_ADDRESS_MASK_REQUEST = 
#  ICMPv6_TYPE_ADDRESS_MASK_REPLY = 

  # Type
  unsigned :type, 8
  # Code
  unsigned :code, 8
  # Checksum
  unsigned :checksum, 16
  rest :message

  # check the checksum for this ICMP packet
  def checksum?
    self.checksum == compute_checksum
  end

  def initialize(*args)
    super(*args)
    @autofix = false
  end


  # compute and set the checksum for this ICMP packet
  def checksum!(src_ip, dst_ip)
    self.checksum = compute_checksum(src_ip, dst_ip)
  end

  # 'fix' this ICMP packet up for sending.
  # (really, just set the checksum)
  def fix!(src_ip, dst_ip)
    self.checksum!(src_ip, dst_ip)
  end

private
  def compute_checksum(src_ip, dst_ip)
    s1 = src_ip >> 96 
    s2 = (src_ip >> 64) & 0x0000FFFF
    s3 = (src_ip >> 32) & 0x00000000FFFF
    s4 = src_ip & 0x000000000000FFFF

    d1 = dst_ip >> 96 
    d2 = (dst_ip >> 64) & 0x0000FFFF
    d3 = (dst_ip >> 32) & 0x00000000FFFF
    d4 = dst_ip & 0x000000000000FFFF

    # pseudo header used for checksum calculation as per RFC 768 
    pseudo = [ s1, s2, s3, s4, d1, d2, d3, d4, self.length, 58, self.type, self.code, 0, self.message ]
    L3::Misc.checksum(pseudo.pack("NNNNNNNNNNCCna*"))
  end
end
# Send raw ICMP packets of your own design
class ICMPv6 < ICMPv6Generic
  rest :payload
end

# ICMP Echo

# Generic ICMPv6 echo, used by request and reply
class ICMPv6Echo < ICMPv6Generic
  unsigned :id, 16
  unsigned :sequence, 16
  rest :payload

  def initialize(*args)
    super(*args)
  end

end

class ICMPv6EchoRequest < ICMPv6Echo
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_ECHO_REQUEST
    self.code = 0
  end

end

# ICMP Echo Reply
class ICMPv6EchoReply < ICMPv6Echo
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_ECHO_REPLY
    self.code = 0
  end
end

# ICMP Destination Unreachable Message
class ICMPv6DestinationUnreachable < ICMPv6Generic
  ICMPv6_CODE_NO_ROUTE = 0 
  ICMPv6_CODE_ADMIN_PROHIBITED = 1
  ICMPv6_CODE_BEYOND_SCOPE = 2 
  ICMPv6_CODE_ADDRESS_UNREACHABLE = 3 
  ICMPv6_CODE_PORT_UNREACHABLE = 4
  ICMPv6_CODE_FAILED_POLICY = 4 
  ICMPv6_CODE_REJECT_ROUTE = 5 
  # This is never used according to the RFC
  unsigned :unused, 32
  # Internet header + 64 bits of original datagram
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_DESTINATION_UNREACHABLE
  end
end

class ICMPv6PacketTooBig < ICMPv6Generic
  # The Maximum Transmission Unit of the next-hop link
  unsigned :mtu, 32
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_PACKET_TOO_BIG
  end

end

# ICMP Time Exceeded Message 
class ICMPv6TimeExceeded < ICMPv6Generic
  ICMPv6_CODE_TTL_EXCEEDED_IN_TRANSIT = 0 
  ICMPv6_CODE_FRAG_REASSEMBLY_TIME_EXCEEDED = 1
  # This is never used according to the RFC
  unsigned :unused, 32
  # As much of the original ICMPv6 packet without busting MTU
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_TIME_EXCEEDED 
  end
end

# ICMPv6 Parameter Problem Message 
class ICMPv6ParameterProblem < ICMPv6Generic
  ICMPv6_CODE_ERRONEOUS_HEADER = 0
  ICMPv6_CODE_UNRECOGNIZED_NEXT_HEADER = 1
  ICMPv6_CODE_UNRECOGNIZED_OPTION = 2
  # pointer to the octet where the error was detected
  unsigned :pointer, 32 
  # As much of the original ICMPv6 packet without busting MTU
  rest :payload

  def initialize(*args)
    super(*args)
    self.type = ICMPv6_TYPE_PARAMETER_PROBLEM
  end
end
end
# vim: set ts=2 et sw=2:
