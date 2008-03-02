# $Id$

require 'bit-struct'
class RacketPart < BitStruct

  # Boolean indicating whether or not this instance should be
  # automatically "fixed" prior to be packed and sent.
  attr_accessor :autofix

  # Should this instance be automatically fixed 
  # prior to being packed and sent?
  def autofix?
    @autofix
  end

  def initialize(*args)
    @autofix = true
    super
  end

  # Print out all of the fields and all of their values
  def pretty
    s  = ""
    self.fields.each do |f|
      unless (f.name == "payload")
        s += "#{f.name}=#{self.send(f.name)} "
      end
    end
    s.gsub(/ $/, '')
  end
 
  def fix!
  end
end
# vim: set ts=2 et sw=2:
