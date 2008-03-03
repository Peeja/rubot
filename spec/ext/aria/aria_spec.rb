# $Id$

require File.join(File.dirname(__FILE__), %w[spec_helper])

unless $spec_skip

describe Aria do
  it "should provide Aria::Init()" do
    pending
    lambda { Aria::init }.should_not raise_error(NoMethodError)
  end
  
  it "should convert ints to bools" do
    Aria::convertBool(0).should == "false"
    Aria::convertBool(1).should == "true"
  end
end

end

# EOF
