float qs[6];
int qind = 0;

void serialComms() {
   if(qind==0){
    Serial.println("N");
   }
   // Populates the qs
  if (qind < 5) {
    while (Serial.available() > 0) {

      char myChar = Serial.read();
      if (myChar == 't')
      {
        qs[qind] = Serial.parseFloat();
        qind++;
      }
    }
  }
  // saves as the qs
  else{
    qa1 = qs[0];
    qa2 = qs[1];
    qa3 = qs[2];
    qa4 = qs[3];
    qa5 = qs[4];
    qind = 0;

  }
}
