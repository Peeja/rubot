#pragma once

#include "Aria.h"

/* 
 * RARangeDevice
 * Wraps an ArRangeDevice to provide a nicer interface.
 * 
 */

class RARangeDevice
{
public:
    RARangeDevice(ArRangeDevice *rangeDevice);
    virtual ~RARangeDevice() {};
    double range(double startAngle, double endAngle);

private:
    ArRangeDevice *myRangeDevice;
};
