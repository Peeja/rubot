require 'facets/string/case'
require 'facets/module/alias'

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
module Rubot
  # Raised when attempting to create a robot with an unrecognized adapter.
  class AdapterMissingError < Exception; end
  
  module Adapters
    class << self
      def const_missing_with_autoload(name)
        begin
          req_name = "rubot/adapters/#{name.to_s.snakecase}"
          require req_name
          if const_defined? name
            return const_get(name)
          else
            raise AdapterMissingError, "Adapter #{name} not loaded by '#{req_name}'."
          end
        rescue LoadError
          raise AdapterMissingError, "Adapter #{name} not found."
        end
      end
      alias_method_chain :const_missing, :autoload
    end
  end
end
