# Require everything except things under rubot/adapters/ (which load lazily).
# (Dir[File.join(::File.dirname(__FILE__), '**', '*.rb')] -
#  Dir[File.join(::File.dirname(__FILE__), 'rubot', 'adapters', '**')]).sort.each {|rb| require rb}

unless defined? Rubot

require 'rubot/adapters'
require 'rubot/meta'

module Rubot  
end

end
