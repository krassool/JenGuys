byte incomingByte1;

void setup() {
  // put your setup code here, to run once:
  pinMode(2,OUTPUT);
  Serial.begin(115200);
  Serial.println("Ready");
}

void loop() {
  // put your main code here, to run repeatedly:

  while(Serial.available() >0){
     char myChar = Serial.read();
 if (myChar == 't')
 {
   float myFloat = Serial.parseFloat();
   Serial.println(myFloat);
 }  
    
  }
}
