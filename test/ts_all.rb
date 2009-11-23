# $Id$

require 'rubygems'

(2..5).each do |l|
  Dir.glob(File.join(File.dirname(__FILE__) + "/l#{l}", '*.rb')).each do |f|
    require f
  end
end

Dir.glob(File.join(File.dirname(__FILE__) + "/misc", '*.rb')).each do |f|
  require f
end
# vim: set ts=2 et sw=2:
