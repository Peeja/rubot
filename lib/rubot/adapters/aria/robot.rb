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
      Thread.new do
        @manager.go args
      end
    end
  end
end
