#pragma once

#include "Aria.h"
#include "RAGenericAction.h"

/* 
 * RARobotManager
 * Encapsulates an ArRobot and its connection.
 * 
 */

class RARobotManager
{
public:
    RARobotManager();
    virtual ~RARobotManager();
    void go(const char *argString);
    void stop();
    void addAction(RAGenericAction *action, int priority);
    void addSensor(Rice::Symbol sensor);
    double getRobotRadius() { return myRobot.getRobotRadius(); }

private:
    ArRobot myRobot;
    ArFunctorC<RARobotManager> myStopCB;
    ArKeyHandler *myRobotKeyHandler;
    
    // Sensors
    ArSonarDevice *mySonar;
};
