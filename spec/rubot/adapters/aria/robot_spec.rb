require File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper])

# fred = Rubot::Adapters::Aria::Robot.new
# fred.options[:host] = 'localhost'

include Rubot::Adapters::Aria

describe Robot do
  before(:each) do
    @mock_manager = mock("manager")
    RobotManager.stub!(:new).and_return(@mock_manager)
    @robot = Robot.new
  end
  
  it "should have options hash" do
    @robot.options[:be_awesome] = true
    @robot.options.keys.should include(:be_awesome)
  end
  
  it "should run the robot" do
    @mock_manager.should_receive(:go)
    @robot.run
  end
  
  it "should connect to the specified host" do
    @robot.options[:host] = 'robothost'
    @mock_manager.should_receive(:go).with(/-remoteHost robothost/)
    @robot.run
  end
  
  it "should connect to the specified port" do
    @robot.options[:port] = 3456
    @mock_manager.should_receive(:go).with(/-remoteRobotTcpPort 3456/)
    @robot.run
  end

  # Add serial connection support.
end
