#include "Aria.h"
#include "RARobotManager.h"

using namespace Rice;


RARobotManager::RARobotManager()
              : myRobot(), myStopCB(this, &RARobotManager::stop)
{
    ArLog::log(ArLog::Normal, "Created robot manager.");
    myRobotKeyHandler = NULL;
    
    // Sensors
    mySonar = NULL;
}

RARobotManager::~RARobotManager()
{
    if (myRobotKeyHandler != NULL)
        delete myRobotKeyHandler;
    if (mySonar != NULL)
        delete mySonar;
    ArLog::log(ArLog::Normal, "Destroyed robot manager.");
}

// Connect to robot and run.
void RARobotManager::go(const char *argString="")
{
    ArArgumentBuilder args;
    args.add(argString);
    ArSimpleConnector conn(&args);
    conn.parseArgs();
    // TODO: Handle connection error
    conn.connectRobot(&myRobot);
    myRobot.enableMotors();
        
    if (myRobotKeyHandler != NULL)
        delete myRobotKeyHandler;
    myRobotKeyHandler = new ArKeyHandler(false, false);
    myRobotKeyHandler->addKeyHandler(ArKeyHandler::ESCAPE, &myStopCB);
    myRobot.attachKeyHandler(myRobotKeyHandler, false);
    
    myRobot.run(true);
}


void RARobotManager::stop()
{
    myRobot.stopRunning();
    if (myRobotKeyHandler != NULL) {
        delete myRobotKeyHandler;
        myRobotKeyHandler = NULL;
    }
}


void RARobotManager::addAction(RAGenericAction *action, int priority)
{
    ArLog::log(ArLog::Normal, "Adding action \"%s\" with priority %d.", action->getName(), priority);
    myRobot.addAction(action, priority);
}


void RARobotManager::addSensor(Symbol sensor)
{
    if (sensor == Symbol("sonar") && mySonar == NULL) {
        mySonar = new ArSonarDevice;
        myRobot.addRangeDevice(mySonar);
    }
    else {
        // TODO: Tell user if sensor is not supported.
    }
}
