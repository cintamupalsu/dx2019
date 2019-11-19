
#include <Servo.h>
#include "SR04.h"
#include <Adafruit_GPS.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <Ethernet.h>

#define TRIG_PIN 12
#define ECHO_PIN 11
#define GPSECHO true

Servo frontServo; 
Servo steerServo;

int pos01 = 90; // front servo position
int pos02 = 90; // steering servo position
int prevpos02 = 90;
int port = 0;
int starboard = 0;
int mainCourse = 10;
bool posMode = true;

SR04 sr04 = SR04(ECHO_PIN, TRIG_PIN);
const int sensorVCCPin = 13;      // VCC Ultrasonic sensor
const int steer_servoVCCPin = 10; // VCC steering servo
const int front_servoVCCPin = 4;  // VCC front servo
const int gpsVCCPin = 7;          // VCC GPS
const int steerCtrl = 8;          // Steer Servo controller at D8
const int frontCtrl = 9;          // Front Servo controller at D9
const int gpsTX = 6;
const int gpsRX = 5;
const float pi = 3.1415926535897932384626433832795;
const float constantaCircle = 0.4; // if ship can move circle maneuver in one minutes then constantaCircle = 1
float latitude = 0;
float longitude = 0;

// Ethernet
byte mac[] = { 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
const char* key = "APIKEY";
const char* host = "https://shielded-reef-91069.herokuapp.com/";
const int httpPort = 80;
EthernetClient client;
// ----

long an_object;
int angle = 0;
float destLat[1];
float destLon[1];

SoftwareSerial softSerial(gpsTX, gpsRX);
Adafruit_GPS GPS(&softSerial);


void setup() {
  pinMode(steer_servoVCCPin, OUTPUT);
  digitalWrite(steer_servoVCCPin, HIGH);

  //pinMode(front_servoVCCPin, OUTPUT);
  //digitalWrite(front_servoVCCPin, HIGH);
  
  pinMode(sensorVCCPin, OUTPUT);
  digitalWrite(sensorVCCPin, HIGH);
  
  pinMode(gpsVCCPin, OUTPUT);
  digitalWrite(gpsVCCPin, HIGH);
  
  delay(1000);

  Serial.begin(115200);

  // Activate Servos
  frontServo.attach(frontCtrl); 
  steerServo.attach(steerCtrl); 
  
  frontServo.write(pos01);  
  steerServo.write(pos02);

  // GPS Setting
  GPS.begin(9600);
  GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCGGA);
  GPS.sendCommand(PMTK_SET_NMEA_UPDATE_1HZ);
  GPS.sendCommand(PGCMD_ANTENNA);

  delay(1000);
  softSerial.println(PMTK_Q_RELEASE);
  
  steerServo.detach();
  destLat[0] = 34.929290;
  destLon[0] = 138.389763;

  //Ethernet
  Ethernet.begin(mac);
}

uint32_t timer = millis();

void loop() {

  if (posMode == true){
    pos01 = pos01 + 5;
    if (pos01 == 135) {
      posMode = false;    
    }
  } else {
    pos01 = pos01 - 5;
    if (pos01 == 45) {
      posMode = true;
    }
  }  

  frontServo.write(pos01);
  delay(100); // Provide time for servo move to given position

  // GPS Testing
  char gpsChar = GPS.read();
  if ((gpsChar) & (GPSECHO))
    Serial.write(gpsChar);
  
  if (GPS.newNMEAreceived()){
    if(!GPS.parse(GPS.lastNMEA()))
      return;
  }

  if (timer > millis()) timer = millis();

  // approximately every 5 minutes, check posisiton and bearing
  if (millis() - timer > (60000*5)){
    timer = millis(); // reset the timer
    if (GPS.fix){ // if received clear signal from GPS
      latitude = GPS.lat - destLat[0];
      longitude = GPS.lon - destLon[0]; 
      float ta = turningangle(GPS.angle,calcangle(latitude,longitude));
      if (ta<0){
        port=millis()+(ta*constantaCircle*1000);
      }else{
        starboard=millis()+((ta*-1)*constantaCircle*1000);
      }
    }
  }

  // adjusting heading
  if ( port > millis()) {
    pos02 = 0;
  }
  if ( starboard > millis()) {
    pos02 = 180;
  }

  // return to straight
  if ((port <= millis()) | (starboard <= millis())){
    pos02 = 90;
  }

  // Ship change direction if necessary
  if (pos02 != prevpos02){
    frontServo.detach();              // turn off front servo
    digitalWrite(sensorVCCPin, LOW);  // turn off sensor
    steerServo.attach(steerCtrl);
    steerServo.write(pos02);
    delay(500);
    prevpos02 = pos02;
    steerServo.detach();
    frontServo.attach(frontCtrl);     // turn on front servo
    digitalWrite(sensorVCCPin, HIGH); // turn on sensor
  }

  // check object
  an_object = sr04.Distance();
  Serial.print(an_object);
  Serial.print("cm ");

  // if object found, change heading
  if ((an_object < 300) & (millis()>5000)){
    float ta = 90 - pos01;
    if (ta>0){
      port = millis()+(ta*constantaCircle*1000);
      timer = timer + (ta*constantaCircle*1000);
    } else{
      starboard=millis()+((ta*-1)*constantaCircle*1000);
      timer = timer + ((ta*-1)*constantaCircle*1000);
    }
    sendToServer(latitude,longitude);
  }
  
  // for easy read on testing
  if (pos01 == 45){
    Serial.println();
  }
  
}

static float degree2rad(float alpha){
  return alpha * ( pi / 180.0);
}

static float rad2degree(float alpha){
  return alpha * (180.0 / pi);
}

static float phytagoras(float a, float b){
  return sqrt((a*a)+(b*b));
}

static float calcangle(float a, float b){
  float c = phytagoras(a,b);
  c = asin(b/c);
  return rad2degree(c);
}

static turningangle(float heading, float destination){
  float c = heading - destination;
  if (c>0){
    if (c<180){
      return c;
    } else {
      return -360+c;
    }
  } else {
    if (c>-180){
      return c;
    } else {
      return 360+c;
    }
  }
}

void sendToServer(float lat, float lon)
{
  client.stop();
  Serial.print("Connecting to");
  Serial.println(host);
  if(!client.connect(host,httpPort)){
    Serial.println("connection failed");
    return;
  }
  String url = "uploadimage/?key=";
  url += key;
  url = url + "&lat="+String(lat)+"&lon="+String(lon) + "&id=1";
  String req = String("GET ") + url;
  Serial.println(req);
  client.print(req);
}
