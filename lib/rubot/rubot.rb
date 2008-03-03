module Rubot
  def self.robots
    @@robots ||= {}
  end
  
  def self.add_robot(name)
    robots[name] = true
  end
end