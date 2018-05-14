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

    char myChar = Serial.read();


    if (myChar == 't') // t denotes the qs are coming
    {
      float myFloat = Serial.parseFloat();
//      Serial.println(myFloat);
      ll++;

    }
    if (myChar == 'h') //h is the header value (int). Sends the chunk length
    {
      float chunkFloat = Serial.parseFloat();
//      Serial.println(chunkFloat);
      int chunkLen = (int) chunkFloat;
    }

    if (myChar == 'f') //h is the header value (int). Sends the chunk length
    {
      float footerFloat = Serial.parseFloat();
      break;
    }

  }

  delay(5000);
  Serial.println("R"); //Lets matlab know we're ready to go



}
