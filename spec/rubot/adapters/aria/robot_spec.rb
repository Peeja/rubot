require File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper])

# fred = Rubot::Adapters::Aria::Robot
# fred.options[:host] = localhost

describe Rubot::Adapters::Aria::Robot do
  before(:each) do
    @robot = Rubot::Adapters::Aria::Robot.new
  end
  
  it "should have options hash" do
    @robot.options[:be_awesome] = true
    @robot.options.keys.should include(:be_awesome)
  end
end
