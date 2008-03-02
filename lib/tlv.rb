# $Id$

# Simple class for your average type, length, value datastructure.
# Everything after the TLV is stuff into +rest+
class TLV
  attr_accessor :type, :length, :value, :rest

  # Create a new TLV which requires +ts+ bytes for the type field
  # and +ls+ bytes for the length field
  def initialize(ts, ls)
    @ts = ts
    @ls = ls
  end 

  # Given +data+, return the type, length, value and rest 
  # values as dictated by this instance.
  def decode(data)
    s = "#{punpack_string(@ts)}#{punpack_string(@ls)}"
    type, length, tmp = data.unpack("#{s}a*")
    value, rest = tmp.unpack("a#{length}a*")
    [type, length, value, rest]
  end

  def decode!(data)
    @type, @length, @value, @rest = self.decode(data)
  end

  # Return a string suitable for use elswhere.
  def encode
    s = "#{punpack_string(@ts)}#{punpack_string(@ls)}"
    [@type, @length, @value].pack("#{s}a*")
  end

  def to_s
    encode
  end

  def to_str
    encode
  end

private
  # XXX: make this handle arbitrarily sized fields
  def punpack_string(size)
    s = ""
    case size
        when 1
          s << "C"
        when 2
          s << "n"
        when 4
          s << "N"
        else
          puts "Size #{s} not supported"
          exit
      end
    s
  end
  

end
# vim: set ts=2 et sw=2:
