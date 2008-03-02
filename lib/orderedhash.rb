# $Id$

# Simple ordered hash. 
#
# XXX: todo -- add a method for moving/shifting
# members around
class OrderedHash < Hash
  def initialize
    @keys = []
  end

  def []=(key, val)
    @keys << key unless (self[key])
    super
  end

  def delete(key)
    @keys.delete(key)
    super
  end

  def each
    @keys.each { |k| yield k, self[k] }
  end

  def each_key
    @keys.each { |k| yield k }
  end

  def each_value
    @keys.each { |k| yield self[k] }
  end
end

# vim: set ts=2 et sw=2:
