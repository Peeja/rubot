#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "Aria.h"

using namespace Rice;

// Initializes Aria if it hasn't been done already.
void ensureAriaInit()
{
	static char inited = 0;
	if (!inited) Aria::init();
	inited = 1;
}


/* 
 * RAAction
 * Generic ArAction that runs a Ruby proc when it fires.
 * 
 */

class RAAction : public ArAction
{
public:
  RAAction(const char *name);
  virtual ~RAAction(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);

protected:
  ArActionDesired myDesired;
};

RAAction::RAAction(const char *name)
				 : ArAction(name)
{}

ArActionDesired *RAAction::fire(ArActionDesired currentDesired)
{
	myDesired.reset();
	myDesired.merge(&currentDesired);
	
	
	return &myDesired;
}


/* 
 * RARobotManager
 * Encapsulates an ArRobot and its connection.
 * 
 */

class RARobotManager
{
public:
	RARobotManager();
	void go(const char *argString);

private:
	ArRobot myRobot;
};

RARobotManager::RARobotManager()
			  : myRobot() {}

// Connect to robot and run.
void RARobotManager::go(const char *argString="")
{
	ensureAriaInit();
	ArArgumentBuilder args;
	args.add(argString);
	ArSimpleConnector conn(&args);
	conn.parseArgs();
	// TODO: Handle connection error
	conn.connectRobot(&myRobot);
	myRobot.enableMotors();
	myRobot.run(true);
}





extern "C"
void Init_rubot_aria()
{
	// Define Rubot::Adapters::Aria.
	Object rb_MRubot = Class(rb_cObject).const_get("Rubot");
	Object rb_MAdapters = Module(rb_MRubot).const_get("Adapters");
	Object rb_MAria = Module(rb_MAdapters)
										.define_module("Aria")
										;
  
	// Define Rubot::Adapters::Aria::RobotManager.
	// Rubot::Adapters::Aria::Robot is defined in Ruby and uses this class.
	Data_Type<RARobotManager> rb_cAriaRobot = Module(rb_MAria)
							                              .define_class<RARobotManager>("RobotManager")
                                            .define_constructor(Constructor<RARobotManager>())
																						.define_method("go",&RARobotManager::go)
							                              ;
}
