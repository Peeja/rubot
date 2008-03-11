#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "Aria.h"

using namespace Rice;

extern "C"
void Init_rubot_aria()
{
	// Define Rubot::Adapters::Aria.
	Object rb_MRubot = Class(rb_cObject).const_get("Rubot");
	Object rb_MAdapters = Module(rb_MRubot).const_get("Adapters");
	Object rb_MAria = Module(rb_MAdapters).define_module("Aria")
    																	  .define_module_function("init", Aria::init)
																				;
  
	// Define Rubot::Adapters::Aria::Robot_.
	// Rubot::Adapters::Aria::Robot wraps this class as a Rubot::Robot subclass,
	// which Rice won't let us define while wrapping a C++ class.
	Data_Type<ArRobot> rb_cAriaRobot = Module(rb_MAria)
																			 .define_class<ArRobot>("Robot_")
                                       .define_constructor(Constructor<ArRobot>())
                                       .define_method("addRangeDevice",&ArRobot::addRangeDevice)
														      		 ;
}
