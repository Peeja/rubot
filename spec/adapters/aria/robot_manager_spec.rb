require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Rubot::Adapters::Aria::RobotManager do
  it "should be creatable" do
    lambda { Rubot::Adapters::Aria::RobotManager.new }.should_not raise_error
  end
  
  # We can't really test that #go works, but we can make sure it's defined.
  it "should connect to robot" do
    Rubot::Adapters::Aria::RobotManager.instance_methods.should include("go")
  end
end
