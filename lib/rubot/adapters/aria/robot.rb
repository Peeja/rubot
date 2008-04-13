module Rubot::Adapters::Aria
  class Robot
    attr_reader :options
  
    def initialize
      @options = {}
      @manager = RobotManager.new
    end
  
    def run
      args = ''
      args << "-remoteHost #{@options[:host]} " if @options[:host]
      args << "-remoteRobotTcpPort #{@options[:port]} " if @options[:port]
      @manager.go args
    end
    
    def add_behavior(behavior, priority)
      raise ArgumentError, "Behavior must be an Aria::Behavior" unless behavior.instance_of? Behavior
      @manager.add_behavior(behavior, priority)
    end
  end
end
