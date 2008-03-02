# $Id$

# Simple class to represent data structures that
# consist of an arbitrary number of length value pairs.
class LV
  # An array containing the values parsed from this LV
  attr_accessor :values
  # The lengths of the values parsed from this LV
  attr_accessor :lengths
  # everything else
  attr_accessor :rest

  # Create a new LV object whose L sizes are specified in +args+
  def initialize(*args)
    @sizes = args
    @values = []
    @lengths = []
  end 


  def decode(data)
    n = 0
    values = []
    lengths = []
    @sizes.each do |s|
      # XXX: raise an error here if there is not enough data to
      # unpack this next LV
      lengths[n] = data.unpack("#{punpack_string(s)}")[0]
      data = data.slice(s, data.length)
      values[n] = data.unpack("a#{lengths[n]}")[0]
      data = data.slice(lengths[n], data.length)
      n += 1
    end

    # data now contains "rest"
    [lengths, values, data]
  end
  
  def decode!(data)
    @lengths, @values, @rest = self.decode(data)
  end

  def encode
    n = 0
    s = ""
    @lengths.each do |l|
      s << [l].pack("#{punpack_string(@sizes[n])}")
      s << [@values[n]].pack("a#{l}")
      n += 1
    end
    s
  end

  def to_s
    encode
  end

  def to_str
    encode
  end

private

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
