require 'facets/string/camelcase'

module Rubot::DSL
  BehaviorFactories = {}
  Robots = {}
  
  class BehaviorFactoryBuilder
    def initialize(name, &block)
      @name = name.to_sym
      self.instance_eval(&block)
    end
    
    def fire(&block)
      @fire = block
    end
    
    def build
      BehaviorFactory.new(@name, @fire)
    end
  end
  
  class BehaviorFactory
    def initialize(name, fire)
      @name = name
      @fire = fire
    end
    
    def create_for_adapter(adapter)
      behavior = Rubot::Adapters.const_get(adapter)::Behavior.new @name.to_s
      behavior.set_fire_proc @fire
      behavior
    end
  end
  
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
      @behaviors.each do |name, priority|
        b = BehaviorFactories[name].create_for_adapter(@adapter)
        robot.add_behavior b, priority
      end
      robot
    end
  end
  
  def behavior(name, &block)
    bb = BehaviorFactoryBuilder.new(name, &block)
    BehaviorFactories[name.to_sym] = bb.build
  end
  
  def robot(name, &block)
    rb = RobotBuilder.new(name, &block)
    Robots[name.to_sym] = rb.build
  end
  
  def run(name)
    Robots[name].run
  end
end
