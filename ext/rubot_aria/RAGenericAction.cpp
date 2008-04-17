#include "rice/Data_Type.hpp"
#include "rice/Symbol.hpp"
#include "rice/Exception.hpp"
#include "Aria.h"

#include "RAGenericAction.h"
#include "RARangeDevice.h"

using namespace Rice;

RAGenericAction::RAGenericAction(const char *name)
                : ArAction(name)
{
    ArLog::log(ArLog::Normal, "Created generic action \"%s\".", name);
    myFireProc = NULL;
    
    // Sensors
    mySonar = NULL;
}

RAGenericAction::~RAGenericAction()
{
    if (myFireProc != NULL)
        delete myFireProc;
    if (mySonar != NULL)
        delete mySonar;
    ArLog::log(ArLog::Normal, "Destroyed generic action \"%s\".", getName());
}

ArActionDesired *RAGenericAction::fire(ArActionDesired currentDesired)
{
    myDesired.reset();
    myDesired.merge(&currentDesired);
        
    if (myFireProc != NULL)
        myFireProc->call("call");
    
    return &myDesired;
}

void RAGenericAction::setFireProc(Object proc)
{
    if (!proc.is_a(rb_cProc))
        throw Exception(rb_eArgError, "proc needs to be a Proc.");
    if (myFireProc != NULL)
        delete myFireProc;
    myFireProc = new Object(proc);
}

void RAGenericAction::setSensors(Object sensors)
{
    // TODO: Make sure rubot_aria supports the given sensors.
    // ArLog::log(ArLog::Normal, "Action \"%s\"'s sensors started with \"%s\".", getName(), Symbol(mySensors.call("first")).c_str());
    mySensors.call("replace", Array(sensors));
    // ArLog::log(ArLog::Normal, "Action \"%s\"'s sensors now start with \"%s\".", getName(), Symbol(mySensors.call("first")).c_str());
}

void RAGenericAction::setRobot(ArRobot *robot)
{
    ArAction::setRobot(robot);
    ArLog::log(ArLog::Normal, "Setting robot for action \"%s\".", getName());
    
    // Acquire sensors.
    // TODO: Handle robot not supporting sensors better.
    for (Array::iterator it = mySensors.begin(); it != mySensors.end(); ++it) {
        if (*it == Symbol("sonar")) {
            ArLog::log(ArLog::Normal, "Adding sonar.");
            if (mySonar != NULL)
                delete mySonar;
            ArRangeDevice *ariaSonar = robot->findRangeDevice("sonar");
            mySonar = (ariaSonar ? new RARangeDevice(ariaSonar) : NULL);
        }
    }
}

Object RAGenericAction::getSensor(Symbol sensor)
{
    if (sensor == Symbol("sonar") && mySonar)
        // FIXME: Is this bad memory management?
        return Data_Object<RARangeDevice>(mySonar);
    else
        return Object(Qnil);
}

Object RAGenericAction::getActionDesired()
{
    return Data_Object<ArActionDesired>(&myDesired);
    // return to_ruby<ArActionDesired *>(&myDesired);
    // return Object(Qnil);
}
