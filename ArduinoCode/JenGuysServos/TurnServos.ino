void turnServos() {
  // no q1 included as this is stepper
  float q1Decimal = (qa1 + 90) ;
  float q2Decimal = (qa2 + 90) ;
  float q3Decimal = (qa3 + 90) ;
  float q4Decimal = (qa4 + 90) ;
  float q5Decimal = (qa5 + 90);

  //  Serial.print(q2Decimal);
  //  Serial.print("  -  ");
  //  Serial.print(q3Decimal);
  //  Serial.print("  -  ");
  //  Serial.print(q4Decimal);
  //  Serial.print("  -  ");
  //  Serial.print(q5Decimal);
  //  Serial.println("  -  ");

  s1.write(q1Decimal); //servos attached in main
  s2.write(q2Decimal); //servos attached in main
  s3.write(q3Decimal);
  s4.write(q4Decimal);
  s5.write(q5Decimal);

}




void attachServos() {
  // put your setup code here, to run once:
  s1.attach(s1_Pin);
  s2.attach(s2_Pin);
  s3.attach(s3_Pin);
  s4.attach(s4_Pin);
  s5.attach(s5_Pin);
}
