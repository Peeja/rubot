#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Exception.hpp"
#include "rice/Array.hpp"
#include "Aria.h"

#include "RAGenericAction.h"
#include "RARobotManager.h"

using namespace std;
using namespace Rice;

extern "C"
void Init_rubot_aria()
{
    static char inited = 0;
    if (!inited) Aria::init(Aria::SIGHANDLE_NONE);
    inited = 1;

    Object rb_MRubot = Class(rb_cObject).const_get("Rubot");
    Object rb_MAdapters = Module(rb_MRubot).const_get("Adapters");
    Object rb_MAria = Module(rb_MAdapters)
                      .define_module("Aria")
                      ;
  
    
    Data_Type<RARobotManager> rb_cRobotManager = Module(rb_MAria)
                                                 .define_class<RARobotManager>("RobotManager")
                                                 .define_constructor(Constructor<RARobotManager>())
                                                 .define_method("go", &RARobotManager::go)
                                                 .define_method("add_behavior", &RARobotManager::addAction)
                                                 .define_method("add_sensor", &RARobotManager::addSensor)
                                                 .define_method("robot_radius", &RARobotManager::getRobotRadius)
                                                 ;
    
    Data_Type<RAGenericAction> rb_cBehavior = Module(rb_MAria)
                                              .define_class<RAGenericAction>("Behavior")
                                              .define_constructor(Constructor<RAGenericAction, const char *>())
                                              .define_method("set_fire_proc", &RAGenericAction::setFireProc)
                                              .define_method("set_sensors", &RAGenericAction::setSensors)
                                              .define_method("get_sensor", &RAGenericAction::getSensor)
                                              .define_method("get_desired", &RAGenericAction::getActionDesired)
                                              ;
    
    Data_Type<ArActionDesiredWrap> rb_cActionDesired = Module(rb_MAria)
                                                       .define_class<ArActionDesiredWrap>("ActionDesired")
                                                       .define_method("velocity", &ArActionDesiredWrap::getVel)
                                                       .define_method("velocity_strength", &ArActionDesiredWrap::getVelStrength)
                                                       .define_method("set_velocity", &ArActionDesiredWrap::setVel)
                                                       .define_method("delta_heading", &ArActionDesiredWrap::getDeltaHeading)
                                                       .define_method("delta_heading_strength", &ArActionDesiredWrap::getDeltaHeadingStrength)
                                                       .define_method("set_delta_heading", &ArActionDesiredWrap::setDeltaHeading)
                                                       .define_method("heading", &ArActionDesiredWrap::getHeading)
                                                       .define_method("heading_strength", &ArActionDesiredWrap::getHeadingStrength)
                                                       .define_method("set_heading", &ArActionDesiredWrap::setHeading)
                                                       ;

    Data_Type<ArRangeDeviceWrap> rb_cRangeDevice = Module(rb_MAria)
                                                   .define_class<ArRangeDeviceWrap>("RangeDevice")
                                                   .define_method("range", &ArRangeDeviceWrap::currentReadingPolar)
                                                   ;
}
