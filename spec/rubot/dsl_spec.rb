require File.dirname(__FILE__) + '/../spec_helper'

module Rubot::Adapters::Acme
  class Robot
    attr_reader :options
    def initialize
      @options = {}
    end
  end
  class Behavior; end
end

describe Rubot::DSL do
  include Rubot::DSL
  
  it "should create a robot" do
    robot :fred do
      adapter :acme
    end
    Rubot::DSL::Robots[:fred].should be_an_instance_of(Rubot::Adapters::Acme::Robot)
  end
end
