# Require everything except things under rubot/adapters/ (which load lazily).
(Dir[File.join(::File.dirname(__FILE__), '**', '*.rb')] -
 Dir[File.join(::File.dirname(__FILE__), 'rubot', 'adapters', '**')]).sort.each {|rb| require rb}
require 'facets/string/case'

module Rubot
  
  # This module contains the robotics adapters.  For instance, the ACME 
  # Robotics adapter would be <tt>Rubot::Adapters::AcmeRobotics</tt>.  Its robot 
  # class would be <tt>Rubot::Adapters::AcmeRobotics::Robot</tt>, and one can be
  # created with
  # 
  #     Rubot.add_robot(:fred, :acme_robotics)
  # 
  # or, in Rubot syntax,
  # 
  #     robot :fred do
  #       adapter :acme_robotics
  #     end
  module Adapters; end
  
  # Raised when attempting to create a robot with an unrecognized adapter.
  class AdapterMissingError < Exception; end
  
  # Returns a hash of the robots Rubot knows about.
  #     my_favorite_bot = Rubot.robots[:fred]
  def self.robots
    @@robots ||= {}
  end
  
  # Creates a new robot named +name+ using the adapter +adapter+ and adds it
  # to Rubot.
  def self.add_robot(name, adapter)
    mod_name = adapter.to_s.camelcase(true).to_sym
    
    unless Adapters.const_defined?(mod_name)
      raise AdapterMissingError, "Adapter #{mod_name} not found."
    end
    
    robots[name] = Adapters.const_get(mod_name).const_get(:Robot).new name
  end
end
