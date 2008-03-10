require File.dirname(__FILE__) + '/../spec_helper'

describe Rubot::Robot do
  before(:each) do
    @robot = Rubot::Robot.new :harry
  end
  
  it "should have a name" do
    @robot.name.should == "harry"
  end
  
  it "should have behaviors" do
    pending
    @robot.should respond_to(:behaviors)
    @robot.behaviors.should respond_to(:[])
  end
end
