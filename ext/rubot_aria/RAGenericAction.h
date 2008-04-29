#pragma once

#include "rice/Array.hpp"
#include "rice/Object.hpp"
#include "rice/Data_Object.hpp"
#include "rice/Address_Registration_Guard.hpp"
#include "Aria.h"

/* 
 * RAGenericAction
 * Generic ArAction that runs a Ruby proc when it fires.
 * 
 */

class RAGenericAction : public ArAction
{
public:
  RAGenericAction(const char *name);
  virtual ~RAGenericAction(void);
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  void setFireProc(Rice::Object proc);
  void setSensors(Rice::Object sensors);
  Rice::Object getSensor(Rice::Symbol sensor);
  virtual void setRobot(ArRobot *robot);
  ArActionDesired *getActionDesired() { return &myDesired; }

protected:
  ArActionDesired myDesired;
  Rice::Object *myFireProc;
  Rice::Address_Registration_Guard *myFireProc_guard;
  Rice::Array mySensors;
  
  // Sensors
  ArRangeDevice *mySonar;
};


// We need a disposable wrapper for ArActionDesired which Ruby can GC at its
// pleasure.  This class delegates all calls to its wrapped ArActionDesired.
// We have to duplicate the entirety of the interface we want Ruby to be able
// to use.  It would be nice to automate this somehow with macros.

class ArActionDesiredWrap
{
public:
    ArActionDesiredWrap(ArActionDesired *obj) { myObj = obj; }
    virtual ~ArActionDesiredWrap() {}
    
    double getVel() const { return myObj->getVel(); }
    double getVelStrength() const { return myObj->getVelStrength(); }
    void setVel(double vel, double strength) const { myObj->setVel(vel, strength); }

    double getDeltaHeading() const { return myObj->getDeltaHeading(); }
    double getDeltaHeadingStrength() const { return myObj->getDeltaHeadingStrength(); }
    void setDeltaHeading(double deltaHeading, double strength) const { myObj->setDeltaHeading(deltaHeading, strength); }
    
    double getHeading() const { return myObj->getHeading(); }
    double getHeadingStrength() const { return myObj->getHeadingStrength(); }
    void setHeading(double heading, double strength) const { myObj->setHeading(heading, strength); }

private:
    ArActionDesired *myObj;
};

template<>
inline
Rice::Object to_ruby<ArActionDesired *>(ArActionDesired * const & x)
{
    return Rice::Data_Object<ArActionDesiredWrap>(new ArActionDesiredWrap(x));
}


// We also need a wrapper for ArRangeDevice.

class ArRangeDeviceWrap
{
public:
    ArRangeDeviceWrap(ArRangeDevice *obj) { myObj = obj; }
    virtual ~ArRangeDeviceWrap() { }
    
    double currentReadingPolar(double startAngle, double endAngle)
    {
        return myObj->currentReadingPolar(startAngle, endAngle, NULL);
    }

private:
    ArRangeDevice *myObj;
};


template<>
inline
Rice::Object to_ruby<ArRangeDevice *>(ArRangeDevice * const & x)
{
    return Rice::Data_Object<ArRangeDeviceWrap>(new ArRangeDeviceWrap(x));
}
