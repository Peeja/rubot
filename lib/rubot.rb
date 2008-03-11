# Require everything except things under rubot/adapters/ (which load lazily).
(Dir[File.join(::File.dirname(__FILE__), '**', '*.rb')] -
 Dir[File.join(::File.dirname(__FILE__), 'rubot', 'adapters', '**')]).sort.each {|rb| require rb}
require 'facets/string/case'

module Rubot  
  # Returns a hash of the robots Rubot knows about.
  #     my_favorite_bot = Rubot.robots[:fred]
  def self.robots
    @@robots ||= {}
  end
  
  # Creates a new robot named +name+ using the adapter +adapter+ and adds it
  # to Rubot.
  def self.add_robot(name, adapter)
    mod_name = adapter.to_s.camelcase(true).to_sym
    
    robots[name] = Adapters.const_get(mod_name).const_get(:Robot).new name
  end
end
