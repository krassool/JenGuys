//Libraries
#include <Servo.h>

//globals
float q1 , q2 , q3 , q4 , q5;
float qa1, qa2, qa3, qa4, qa5;
float pi = 3.1416;
float qa1old = 0; // initilaise stepper adjusted angle

//geometry
int b = 125;
int L1 = 180;
int L2 = 172;
int L3 = 110;

// time step
float time_step = 100; // in milliseconds for arduino

//servo init
Servo s1;
Servo s2;
Servo s3;
Servo s4;
Servo s5;

//servo pins
int s1_Pin = 3; //    pin 9 these are the digital pins that the servos are attached to
int s2_Pin = 5;
int s3_Pin = 6; //3
int s4_Pin = 10;
int s5_Pin = 9;

//solenoid valve pin
int sol_Pin = 7; // digital pin for solenpoid

//number of trajectories
int numTraj;

// loop variable
int l=0;

//
bool suction = true;

//function prototypes
void attachServos();
void turnServos();
void adjustAngles();
void serialComms();


void setup() {
  //  Q2mat = -1.00*Q2mat;
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
    //    state_start_time = start_time; //initialise the start time for the first state
    pinMode(sol_Pin, OUTPUT);

  }
  attachServos();
  delay(1000);


// Read the number of trajectories. Should be first from MATLAB
  char myChar = Serial.read();
      if (myChar == 'm')
      {
        numTraj = (int) Serial.parseFloat();     
      }

  
}


//send position length, then
void loop() {
  l++;

  if(  (l % numTraj)==0){
    suction=~suction;
    suctionCup();
  }

  serialComms();

  //        qa1 = 0;
  //        qa2 = 0;
  //        qa3 = 0;
  //        qa4 = 0;
  //        qa5 = 0;


  //    adjustAngles();
  turnServos();

  delay(time_step);

  //    if(


}

