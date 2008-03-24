require 'rubot' if not defined? Rubot
require 'rubot_aria'

class Rubot::Adapters::Aria::Robot
  attr_reader :options
  
  def initialize
    @options = []
  end
end