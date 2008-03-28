module Rubot::Adapters::Aria
  class Robot
    attr_reader :options
  
    def initialize
      @options = {}
      @manager = RobotManager.new
    end
  
    def run
      @manager.go ""
    end
  end
end
