# $Id$

# Bootstrap Protocol -- BOOTP
#
# RFC951 (http://www.faqs.org/rfcs/rfc951.html)
class BOOTP < RacketPart
  BOOTP_REQUEST = 1
  BOOTP_REPLY = 2

  # Message type
  unsigned :type, 8 
  # Hardware address type
  unsigned :hwtype, 8, { :default => 1 }
  # Hardware adddress length
  unsigned :hwlen, 8, { :default => 6 }
  # Hops between client and server
  unsigned :hops, 8
  # Transaction ID
  unsigned :id, 32 
  # Seceonds elapsed since client started trying to boot
  unsigned :secs, 16
  # Flags.  Generally unused
  unsigned :flags, 16
  # Client IP address
  octets :cip, 32
  # "Your" (client) IP address.
  octets :yip, 32
  # Server IP address
  octets :sip, 32
  # Gateway IP address
  octets :gip, 32
  # Client hardware address
  hex_octets :chaddr, 128
  # Optional server host name
  text :server, 512
  # Boot file name
  text :file, 1024
  # Payload
  rest :payload

  def add_option(number, value)
    o = TLV.new(1,1)
    o.type = number
    o.value = value
    o.length = value.length
    @options << o.encode
  end

  def fix!
    # tack on an EOL to the options
    newpayload = @options.join + "\xff"
   
    # pad out to 64 bytes
    while (newpayload.length != 64)
      newpayload += "\x00"
    end

    self.payload = newpayload + self.payload
  end

  def to_s
    puts "to_s"
  end

  def to_str
    puts to_str
  end

  def initialize(*args)
    @options = []
    @options << "\x63\x82\x53\x63" # magic
    super
    @autofix = false
  end

end
# vim: set ts=2 et sw=2:
