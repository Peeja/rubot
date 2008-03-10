#include "ruby.h"

void Init_rubot_asimov()
{
	// Define Rubot::Adapters::Asimov
	VALUE rb_MRubot = rb_const_get(rb_cObject, rb_intern("Rubot"));
	VALUE rb_MAdapters = rb_const_get(rb_MRubot,rb_intern("Adapters"));
	VALUE rb_MAsimov = rb_define_module_under(rb_MAdapters, "Asimov");
	
	// Define Rubot::Adapters::Asimov::Robot
	VALUE rb_cRobot = rb_const_get(rb_MRubot, rb_intern("Robot"));
	VALUE rb_cAsimovRobot = rb_define_class_under(rb_MAsimov, "Robot", rb_cRobot);
}
