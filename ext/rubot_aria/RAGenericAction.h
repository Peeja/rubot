#pragma once

#include "rice/Array.hpp"
#include "rice/Object.hpp"
#include "rice/Data_Object.hpp"
#include "Aria.h"

#include "RARangeDevice.h"

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
  // RARangeDevice *getSensor(Rice::Symbol sensor);
  virtual void setRobot(ArRobot *robot);
  // ArActionDesired *getActionDesired() { return &myDesired; }
  Rice::Object getActionDesired();

protected:
  ArActionDesired myDesired;
  Rice::Object *myFireProc;
  Rice::Array mySensors;
  
  // Sensors
  RARangeDevice *mySonar;
};
