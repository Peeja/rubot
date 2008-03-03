require File.join(File.dirname(__FILE__), %w[spec_helper])

describe Rubot do
  it "should have robots" do
    Rubot.should respond_to(:robots)
    Rubot.robots.should respond_to(:[])
  end
  
  it "should let the user add a robot" do
    Rubot.should respond_to(:add_robot)
    lambda { Rubot.add_robot(:fred) }.should change { Rubot.robots.length }.by(1)
  end
end
