#include "Aria.h"

#include "RARangeDevice.h"

RARangeDevice::RARangeDevice(ArRangeDevice *rangeDevice)
{
    myRangeDevice = rangeDevice;
}

double RARangeDevice::range(double startAngle, double endAngle)
{
    return myRangeDevice->currentReadingPolar(startAngle, endAngle, NULL);
}
