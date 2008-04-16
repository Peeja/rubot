require 'facets/string/camelcase'
require 'facets/symbol/to_proc'

module Rubot::DSL
  BehaviorFactories = {}
  Robots = {}
  
  class BehaviorFactoryBuilder
    def initialize(name, &block)
      @name = name.to_sym
      @sensors = []
      self.instance_eval(&block)
    end
    
    # Defines the block of code to run when this behavior fires.
    # 
    #   behavior :do_stuff do
    #     fire do
    #       # Do stuff
    #     end
    #   end
    def fire(&block)
      @fire = block
    end
    
    # Specifies sensors to make available to the fire block.
    # 
    #   behavior :log_sonar do
    #     sensors :sonar
    #     fire do
    #       puts "Sonar is reading #{sonar.range(-70,70)}"
    #     end
    #   end
    def sensors(*sensors)
      @sensors += sensors.map(&:to_sym)
    end
    
    def build
      BehaviorFactory.new(@name, @fire, @sensors.uniq)
    end
  end
  
  class BehaviorFactory
    def initialize(name, fire, sensors)
      @name = name
      @fire = fire
      @sensors = sensors
    end
    
    def create_for_robot(robot)
      BehaviorContext.new(@name, @fire, @sensors, robot).behavior
    end
  end
  
  class BehaviorContext
    attr_reader :behavior, :robot
    def initialize(name, fire, sensors, robot)
      @name = name
      @fire = fire
      @sensors = sensors
      @robot = robot
      @behavior = Rubot::Adapters.const_get(robot.adapter)::Behavior.new name.to_s
      # Have the behavior execute the fire proc in context of this object.
      @behavior.set_fire_proc Proc.new { self.instance_eval(&@fire) }
      @behavior.set_sensors @sensors
    end
    
    # Return the named sensor, if one is given.
    def method_missing(sym, *args)
      if @sensors.include? sym
        @behavior.get_sensor(sym)
      else
        super
      end
    end
    
    # def desired
  end
  
  class RobotBuilder
    attr_reader :adapter
    def initialize(name, &block)
      @name = name.to_sym
      @options = {}
      @sensors = []
      @behaviors = []
      self.instance_eval(&block)
    end
    
    # Set the adapter for the robot, if name is given.  Otherwise, return the adapter
    def adapter(name=nil)
      # TODO: Stop user from changing the adapter once set.
      @adapter = name.to_s.camelcase(true).to_sym if name
      @adapter
    end
    
    def sensors(*sensors)
      @sensors += sensors.map(&:to_sym)
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
      @sensors.each { |s| robot.add_sensor s }
      @behaviors.each do |name, priority|
        b = BehaviorFactories[name].create_for_robot(self)
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
