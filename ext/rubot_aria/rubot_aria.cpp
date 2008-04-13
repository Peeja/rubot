#include <csignal>
#include <iostream>
#include "rice/Module.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "rice/Exception.hpp"
#include "Aria.h"

using namespace std;
using namespace Rice;

// Initializes Aria if it hasn't been done already.
void ensureAriaInit()
{
    static char inited = 0;
    if (!inited) Aria::init(Aria::SIGHANDLE_NONE);
    inited = 1;
}


/* 
 * RAGenericAction
 * Generic ArAction that runs a Ruby proc when it fires.
 * 
 */

class RAGenericAction : public ArAction
{
public:
  RAGenericAction(const char *name);
  virtual ~RAGenericAction(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  void setFireProc(Object proc);

protected:
  ArActionDesired myDesired;
  Object *myProcP;
};

RAGenericAction::RAGenericAction(const char *name)
                 : ArAction(name)
{
    ArLog::log(ArLog::Normal, "Created generic action \"%s\".", name);
    myProcP = NULL;
}

ArActionDesired *RAGenericAction::fire(ArActionDesired currentDesired)
{
    myDesired.reset();
    myDesired.merge(&currentDesired);
        
    if (myProcP != NULL)
        myProcP->call("call");
    
    return &myDesired;
}

void RAGenericAction::setFireProc(Object proc)
{
    if (!proc.is_a(rb_cProc))
        throw Exception(rb_eArgError, "proc needs to be a Proc.");
    if (myProcP != NULL)
        delete myProcP;
    myProcP = new Object(proc);
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
    void stop();
    void addAction(RAGenericAction *action, int priority);

private:
    ArRobot myRobot;
    ArFunctorC<RARobotManager> myStopCB;
    ArKeyHandler *myRobotKeyHandlerP;
};

// Not working yet
// void handler(int signum)
// {
//     cout << "Got signal." << endl;
// }

RARobotManager::RARobotManager()
              : myRobot(), myStopCB(this, &RARobotManager::stop)
{
    myRobotKeyHandlerP = NULL;
}

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
    
    // Not working yet.
    // signal(SIGINT, handler);
    
    if (myRobotKeyHandlerP != NULL)
        delete myRobotKeyHandlerP;
    myRobotKeyHandlerP = new ArKeyHandler(false, false);
    myRobotKeyHandlerP->addKeyHandler(ArKeyHandler::ESCAPE, &myStopCB);
    myRobot.attachKeyHandler(myRobotKeyHandlerP, false);
    
    myRobot.run(true);
}


void RARobotManager::stop()
{
    myRobot.stopRunning();
    if (myRobotKeyHandlerP != NULL)
        delete myRobotKeyHandlerP;
}


void RARobotManager::addAction(RAGenericAction *action, int priority)
{
    ArLog::log(ArLog::Normal, "Adding action \"%s\" with priority %d.", action->getName(), priority);
    myRobot.addAction(action, priority);
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
    Data_Type<RARobotManager> rb_cRobotManager = Module(rb_MAria)
                                                 .define_class<RARobotManager>("RobotManager")
                                                 .define_constructor(Constructor<RARobotManager>())
                                                 .define_method("go",&RARobotManager::go)
                                                 .define_method("add_behavior", &RARobotManager::addAction)
                                                 ;
    
    Data_Type<RAGenericAction> rb_cBehavior = Module(rb_MAria)
                                              .define_class<RAGenericAction>("Behavior")
                                              .define_constructor(Constructor<RAGenericAction, const char *>())
                                              .define_method("set_fire_proc", &RAGenericAction::setFireProc)
                                              ;
}
