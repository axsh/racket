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
# Virtual Router Redundancy Protocol (VRRP)
# http://tools.ietf.org/html/rfc2338
# http://tools.ietf.org/html/rfc3768
module Racket
class VRRP < RacketPart
  unsigned :version, 4
  unsigned :type, 4 
  unsigned :id, 8
  unsigned :priority, 8
  unsigned :num_ips, 8
  unsigned :auth_type, 8
  unsigned :interval, 8
  unsigned :csum, 16
  rest :payload

  def add_ip(ip)
    @ips << L3::Misc.ipv42long(ip)
  end

  def checksum?
    self.csum == compute_checksum
  end

  def checksum!
    self.csum = compute_checksum
  end

  # (really, just set the checksum)
  def fix!
    self.payload = @ips.pack("N#{@ips.size}")
    self.num_ips = @ips.size
    self.checksum!
  end

  def initialize(*args)
    @ips = []
    @authdata = ""
    super
  end

private
  def compute_checksum
    # pseudo header used for checksum calculation as per RFC 768 
    pseudo = [ ((self.version << 4) | self.type), self.id, self.priority, self.num_ips, self.auth_type, self.interval, 0, self.payload ] 
    L3::Misc.checksum(pseudo.pack("CCCCCCna*"))
  end
end
end
# vim: set ts=2 et sw=2:
