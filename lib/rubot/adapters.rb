require 'facets/string/case'

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
module Adapters
  # Raised when attempting to create a robot with an unrecognized adapter.
  class AdapterMissingError < Exception; end

  def self.const_missing(name)
    begin
      little_name = name.to_s.snakecase
      require "rubot/adapters/#{little_name}"
      return get_const(name)
    rescue LoadError, NameError
      raise AdapterMissingError, "Adapter #{mod_name} not found."
    end
  end
end
