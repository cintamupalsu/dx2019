# SBS on IBM DXチャレンジ 2019

This is the application for answering challenge from IBM

## License

All source code in the Project Seal is available jointly under the MIT License. See [M_LICENSE.md](M_LICENSE.md) for details

## Getting started

to get started with app, clone the repo and then install the need gems;

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the application in a local server:

```
$ rails server
```

For more information, please contact a_maulana at sbs-infosys.co.jp

## Environment variable

WVRAK = Watson Visual Recognition API Key

# Architecture
Please see

[public/diagram/DX2019Architecture.pdf](public/diagram/DX2019Architecture.pdf)


# IoT

for the ship device, you will need this some hardware


## Hardware

1. Arduinos & Cam
2. Servo motors
3. Power supply module
4. DC Motor
5. Ultrasonic Sensor
6. Female-to-male Dupont wire
7. 830 Tie-Points Breadboard
8. Jumper Wire
9. 3D Printer
10. Solar panel battery.

## Building the ship

Print all STL files located in folder
```
public/stl
```
using 3D printer.
Place the hardware (Arduino, Servo motors, etc.) into the ship and connect them.
See the diagram in the folder
[public/diagram/DX2019Architecture.pdf](public/diagram/DX2019Architecture.pdf)
to connect the parts.
Then copy the file code in folder
```
public/micro
```
and upload to  ESP8266.
Register the IoT into the system.
For details please check this video:
https://youtu.be/LTkDhwy6I6U
