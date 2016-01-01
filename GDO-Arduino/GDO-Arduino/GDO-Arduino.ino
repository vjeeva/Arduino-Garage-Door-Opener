void setup() {
  // put your setup code here, to run once:
  pinMode(13, OUTPUT);
  
  //Setup IoT Connection for Processing Application
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  Serial.begin(9600);
  delay(200);
  if(Serial.available() > 0){
    String command = Serial.readString();
    if (command == "0" || command == "1"){
      Serial.end();
      digitalWrite(13, 1);
      delay(1000);
      digitalWrite(13, 0);
      delay(15000);
    }
  }
  
}
