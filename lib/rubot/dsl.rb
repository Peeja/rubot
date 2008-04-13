require 'facets/string/camelcase'

module Rubot::DSL
  Robots = {}
  Behaviors = {}
  
  class RobotBuilder
    def initialize(name, &block)
      @name = name.to_sym
      @options = {}
      @behaviors = []
      self.instance_eval(&block)
    end
    
    def adapter(name)
      @adapter = name.to_s.camelcase(true).to_sym
    end
    
    def behavior(name, priority)
      @behaviors << [name.to_sym, priority]
    end
    
    def method_missing(opt, *args)
      @options[opt] = ( args.size == 1 ? args.first : args )
      nil
    end
    
    def build
      raise "Robot #{@name} declared without an adapter." unless @adapter
      robot = Rubot::Adapters.const_get(@adapter)::Robot.new
      robot.options.merge! @options
      @behaviors.each { |n, p| robot.add_behavior Behaviors[n], p }
      robot
    end
  end
  
  class BehaviorBuilder
    def initialize(name, &block)
      @name = name.to_sym
      self.instance_eval(&block)
    end
    
    def adapter(name)
      @adapter = name.to_s.camelcase(true).to_sym
    end
    
    def fire(&block)
      @fire = block
    end
    
    def build
      raise "Behavior #{@name} declared without an adapter." unless @adapter
      behavior = Rubot::Adapters.const_get(@adapter)::Behavior.new @name.to_s
      behavior.set_fire_proc @fire
      behavior
    end
  end
  
  def robot(name, &block)
    rb = RobotBuilder.new(name, &block)
    Robots[name.to_sym] = rb.build
  end
  
  def behavior(name, &block)
    bb = BehaviorBuilder.new(name, &block)
    Behaviors[name.to_sym] = bb.build
  end
  
  def run(name)
    Robots[name].run
  end
end