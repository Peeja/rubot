require File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper])

# fred = Rubot::Adapters::Aria::Robot.new
# fred.options[:host] = localhost

include Rubot::Adapters::Aria

describe Robot do
  before(:each) do
    @mock_manager = mock("manager")
    RobotManager.should_receive(:new).and_return(@mock_manager)
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
  
  # Test args
end
