//Libraries
#include <Servo.h>



// temp BS long matrices
double Q1mat[] = {17.2, 17.1, 16.7, 16.2, 15.6, 15.0, 14.7, 14.6, 15.0, 15.8, 17.2, 18.6, 19.5, 19.9, 20.1, 20.0, 19.7, 19.2, 18.6, 17.8, 16.9, 15.9, 14.9, 13.8, 12.7, 11.7, 10.8, 10.0, 9.3, 8.9, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8, 8.8};
double Q2mat[] = {56.2, 55.7, 54.3, 52.1, 49.5, 46.8, 44.0, 41.7, 40.0, 39.5, 40.5, 42.4, 44.2, 45.9, 47.3, 48.3, 49.1, 49.5, 49.6, 49.6, 49.3, 49.0, 48.5, 48.1, 47.7, 47.3, 46.9, 46.5, 46.2, 45.9, 45.6, 45.6, 46.3, 47.6, 49.4, 51.5, 53.8, 56.1, 58.1, 59.5, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0};
double Q3mat[] = {33.2, 33.2, 32.9, 32.4, 31.3, 29.6, 27.3, 24.4, 20.8, 16.8, 12.3, 7.9, 4.3, 1.6, -0.5, -1.8, -2.4, -2.5, -2.1, -1.3, -0.2, 1.1, 2.6, 4.1, 5.6, 6.9, 8.1, 8.9, 9.5, 9.7, 9.4, 9.5, 10.8, 13.1, 15.9, 19.0, 22.1, 24.8, 27.0, 28.5, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0};
double Q4mat[] = { -51.2, -51.2, -50.9, -50.4, -49.3, -47.6, -45.3, -42.4, -38.8, -34.8, -30.3, -25.9, -22.3, -19.6, -17.5, -16.2, -15.6, -15.5, -15.9, -16.7, -17.8, -19.1, -20.6, -22.1, -23.6, -24.9, -26.1, -26.9, -27.5, -27.7, -27.4, -27.5, -28.8, -31.1, -33.9, -37.0, -40.1, -42.8, -45.0, -46.5, -47.0, -47.0, -47.0, -47.0, -47.0, -47.0, -47.0, -47.0, -47.0, -47.0};
double Q5mat[] = { -12.8, -12.9, -13.3, -13.8, -14.4, -15.0, -15.3, -15.4, -15.0, -14.2, -12.8, -11.4, -10.5, -10.1, -9.9, -10.0, -10.3, -10.8, -11.4, -12.2, -13.1, -14.1, -15.1, -16.2, -17.3, -18.3, -19.2, -20.0, -20.7, -21.1, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2, -21.2};

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
float time_step = 200; // in milliseconds for arduino

//servo init
Servo s1;
Servo s2;
Servo s3;
Servo s4;
Servo s5;

//servo pins
int s1_Pin = 13; // these are the digital pins that the servos are attached to
int s2_Pin = 3; 
int s3_Pin = 5;
int s4_Pin = 6;
int s5_Pin = 9;




//function prototypes
void attachServos();
void turnServos();
void adjustAngles();


void setup() {
  //  Q2mat = -1.00*Q2mat;
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
    //    state_start_time = start_time; //initialise the start time for the first state
  }
  attachServos();
}


//send position length, then
void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i < 50; i++) { //50 is arbitray, jus for testing. should be to 
    //    q1 = Q1mat[i];
    //    q2 = Q2mat[i];
    //    q3 = Q3mat[i];
    //    q4 = Q4mat[i];
    //    q5 = Q5mat[i];

    q1 = -20;
    q2 = 0;
    q3 = 0;
    q4 = 0;
    q5 = 0;

    adjustAngles();
    turnServos();

    delay(time_step);

  }

}

