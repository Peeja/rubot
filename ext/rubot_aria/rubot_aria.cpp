#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Exception.hpp"
#include "rice/Array.hpp"
#include "Aria.h"

#include "RAGenericAction.h"
#include "RARobotManager.h"
#include "RARangeDevice.h"

using namespace std;
using namespace Rice;

extern "C"
void Init_rubot_aria()
{
    static char inited = 0;
    if (!inited) Aria::init(Aria::SIGHANDLE_NONE);
    inited = 1;

    // Define Rubot::Adapters::Aria.
    Object rb_MRubot = Class(rb_cObject).const_get("Rubot");
    Object rb_MAdapters = Module(rb_MRubot).const_get("Adapters");
    Object rb_MAria = Module(rb_MAdapters)
                      .define_module("Aria")
                      ;
  
    
    // Define Rubot::Adapters::Aria::RobotManager.
    // Rubot::Adapters::Aria::Robot is defined in Ruby and uses this class.
    Data_Type<RARobotManager> rb_cRobotManager = Module(rb_MAria)
                                                 .define_class<RARobotManager>("RobotManager")
                                                 .define_constructor(Constructor<RARobotManager>())
                                                 .define_method("go", &RARobotManager::go)
                                                 .define_method("add_behavior", &RARobotManager::addAction)
                                                 .define_method("add_sensor", &RARobotManager::addSensor)
                                                 ;
    
    Data_Type<RAGenericAction> rb_cBehavior = Module(rb_MAria)
                                              .define_class<RAGenericAction>("Behavior")
                                              .define_constructor(Constructor<RAGenericAction, const char *>())
                                              .define_method("set_fire_proc", &RAGenericAction::setFireProc)
                                              .define_method("set_sensors", &RAGenericAction::setSensors)
                                              .define_method("get_sensor", &RAGenericAction::getSensor)
                                              .define_method("get_desired", &RAGenericAction::getActionDesired)
                                              ;
    
    Data_Type<ArActionDesired> rb_cActionDesired = Module(rb_MAria)
                                                   .define_class<ArActionDesired>("ActionDesired")
                                                   .define_method("velocity", &ArActionDesired::getVel)
                                                   .define_method("velocity_strength", &ArActionDesired::getVelStrength)
                                                   .define_method("set_velocity", &ArActionDesired::setVel)
                                                   .define_method("delta_heading", &ArActionDesired::getDeltaHeading)
                                                   .define_method("delta_heading_strength", &ArActionDesired::getDeltaHeadingStrength)
                                                   .define_method("set_delta_heading", &ArActionDesired::setDeltaHeading)
                                                   .define_method("heading", &ArActionDesired::getHeading)
                                                   .define_method("heading_strength", &ArActionDesired::getHeadingStrength)
                                                   .define_method("set_heading", &ArActionDesired::setHeading)
                                                   // .define_method("max_velocity", &ArActionDesired::getMaxVel)
                                                   // .define_method("max_velocity_strength", &ArActionDesired::getMaxVelStrength)
                                                   // .define_method("set_max_velocity", &ArActionDesired::setMaxVel)
                                                   // .define_method("max_reverse_velocity", &ArActionDesired::getMaxNegVel)
                                                   // .define_method("max_reverse_velocity_strength", &ArActionDesired::getMaxNegVelStrength)
                                                   // .define_method("set_max_reverse_velocity", &ArActionDesired::setMaxNegVel)
                                                   // .define_method("max_rotational_velocity", &ArActionDesired::getMaxRotVel)
                                                   // .define_method("max_rotational_velocity_strength", &ArActionDesired::getMaxRotVelStrength)
                                                   // .define_method("set_max_rotational_velocity", &ArActionDesired::setMaxRotVel)
                                                   ;

    Data_Type<RARangeDevice> rb_cRangeDevice = Module(rb_MAria)
                                               .define_class<RARangeDevice>("RangeDevice")
                                               .define_method("range", &RARangeDevice::range)
                                               ;
}
