require File.join(File.dirname(__FILE__), %w[spec_helper])

module Rubot::Adapters::AcmeRobotics
  class Robot < Rubot::Robot; end
end

describe Rubot do
  it "should have robots" do
    Rubot.should respond_to(:robots)
    Rubot.robots.should respond_to(:[])
  end
  
  it "should create robots" do
    Rubot.should respond_to(:add_robot)
    Rubot.add_robot(:fred, :acme_robotics)
    Rubot.robots[:fred].should be_a_kind_of(Rubot::Adapters::AcmeRobotics::Robot)
  end
  
  it "should not add a robot from an unknown adapter" do
    lambda { Rubot.add_robot(:roger, :johnson_bots) }.should raise_error(Rubot::AdapterMissingError)
  end
end
