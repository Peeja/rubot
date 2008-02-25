require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe Aria::Robot do
  it "should be createable" do
    lambda { Aria::Robot.new }.should_not raise_error(TypeError)
  end
  
  it "should let us add a range device" do
    r = Aria::Robot.new
    lambda { r.addRangeDevice }.should_not raise_error(NoMethodError)
  end
end