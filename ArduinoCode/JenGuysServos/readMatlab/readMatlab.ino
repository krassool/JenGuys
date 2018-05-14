byte incomingByte1;

void setup() {
  // put your setup code here, to run once:
  pinMode(2, OUTPUT);
  Serial.begin(115200);
  Serial.println("I"); //initialise. Lets matlab know we're ready to go
}

void loop() {
  // put your main code here, to run repeatedly:
  int  ll = 0; // reset the chunk length
  int chunkLen = 50; //default chunk length value



  while (Serial.available() > 0) {

    // Read the next char coming in
    char myChar = Serial.read();

//checks to see if it is a 'q value'
    if (myChar == 't') // t denotes the qs are coming
    {
      float myFloat = Serial.parseFloat();
      ll++;

    }

    //checks to see if it is a header value
    if (myChar == 'h') //h is the header value (int). Sends the chunk length
    {
      float chunkFloat = Serial.parseFloat();
      int chunkLen = (int) chunkFloat;
    }


//checks to see if it's a footer value
    if (myChar == 'f') //h is the header value (int). Sends the chunk length
    {
      float footerFloat = Serial.parseFloat();
      break;
    }

  }

// this stuff is temporary. Once this is turned in to a function
// the serial println can be done at the end of the 50 trajectories,
// at the start of thi readMatlab function. (not just on a mindless delay loop)
  delay(1000);
  Serial.println("R"); //Lets matlab know we're ready to go



}
