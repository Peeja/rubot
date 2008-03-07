Dir[File.join(::File.dirname(__FILE__), '**', '*.rb')].sort.each {|rb| require rb}
require 'facets/string/case.rb'

module Rubot
  
  # This module contains the robotics adapters.  For instance, the ACME 
  # Robotics adapter would be +Rubot::Adapters::AcmeRobotics+.  Its robot 
  # class would be +Rubot::Adapters::AcmeRobotics::Robot+, and it can be 
  module Adapters; end
  
  # Raised when attempting to create a robot with an unrecognized adapter.
  class AdapterMissingError < Exception; end
  
  def self.robots
    @@robots ||= {}
  end
  
  def self.add_robot(name, adapter, options={})
    mod_name = adapter.to_s.camelcase(true).to_sym
    
    unless Adapters.const_defined?(mod_name)
      raise AdapterMissingError, "Adapter #{mod_name} not found."
    end
    
    robots[name] = Adapters.const_get(mod_name).const_get(:Robot).new
  end
end
