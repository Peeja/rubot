#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "Aria.h"

using namespace Rice;

const char *convertBool(Object /* self */, int val) {
  return ArUtil::convertBool(val);
}

extern "C"
void Init_rubot_aria()
{
  Module rb_MAria =
    define_module("Aria")
    // .define_module_function("init", init)
    .define_module_function("convertBool", convertBool);
  
  Data_Type<ArRobot> rb_cRobot = rb_MAria.define_class<ArRobot>("Robot")
                                         .define_constructor(Constructor<ArRobot>())
                                         .define_method("addRangeDevice",&ArRobot::addRangeDevice);
}
