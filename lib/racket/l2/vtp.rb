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
# VLAN Trunking Protocol (VTP)
# http://en.wikipedia.org/wiki/VLAN_Trunking_Protocol
class VTP < RacketPart
  # VTP version (1-3)
  unsigned :version, 8 
  # Message code (summary advertisement, subset advertisement, advertisement request, VTP join)
  unsigned :code, 8 
  # Sometimes used, sometimes not, depends on the type
  unsigned :reserved, 8  
  # Length of the management domain
  unsigned :domain_length, 8
  # management domain name, zero padded to 32 bytes
  text :domain, 256
  rest :payload

  # Adjust +domain_length+ and +domain+ accordingly prior to sending
  def fix!
    self.domain_length = self.domain.length 
    self.domain = self.domain.ljust(32, "\x00")
  end

end
end
# vim: set ts=2 et sw=2:
