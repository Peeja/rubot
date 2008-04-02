module Rubot::Adapters::Aria
  class Robot
    attr_reader :options
  
    def initialize
      @options = {}
      @manager = RobotManager.new
    end
  
    def run
      args = ''
      args << "-rh #{@options[:host]}" if @options[:host]
      @manager.go args
    end
  end
end
