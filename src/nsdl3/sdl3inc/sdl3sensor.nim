##  Sensor event definitions.
##
#[
  SPDX-License-Identifier: NCSA OR MIT OR Zlib
]#

{.push raises: [].}

type
  Sensor* = ptr object
    ##  Sensor.

  SensorID* = distinct uint32
    ##  Sensor unique ID.
    ##
    ##  The ID starts at 1. Invalid ID has value 0.

  SensorType* {.size: cint.sizeof.} = enum
    ##  Sensor types.
    SENSOR_INVALID   = -1   ##  Returned for an invalid sensor.
    SENSOR_UNKNOWN          ##  Unknown sensor type.
    SENSOR_ACCEL            ##  Accelerometer.
    SENSOR_GYRO             ##  Gyroscope.
    SENSOR_ACCEL_L          ##  Accelerometer for left Joy-Con controller
                            ##  and Wii nunchuk.
    SENSOR_GYRO_L           ##  Gyroscope for left Joy-Con controller.
    SENSOR_ACCEL_R          ##  Accelerometer for right Joy-Con controller.
    SENSOR_GYRO_R           ##  Gyroscope for right Joy-Con controller.

const
  STANDARD_GRAVITY* = cfloat 9.80665

# vim: set sts=2 et sw=2:
