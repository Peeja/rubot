require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Rubot::Adapters::Aria::Robot do
  before(:each) do
    @robot = Rubot::Adapters::Aria::Robot.new
  end
  
  it "should have options array" do
    @robot.options << :be_awesome
    @robot.options.should include(:be_awesome)
  end
end
