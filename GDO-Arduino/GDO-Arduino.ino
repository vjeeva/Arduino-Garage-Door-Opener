void setup() {
  // put your setup code here, to run once:
  pinMode(13, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(7, INPUT);
  
  //Setup IoT Connection for Processing Application
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly
  digitalWrite(2,1);
  
  Serial.begin(9600);
  delay(200);
  if(Serial.available() > 0){
    String command = Serial.readString();
    if (command == "0" || command == "1"){
      Serial.end();
      digitalWrite(13, 1);
      delay(500);
      digitalWrite(13, 0);
      delay(13000);
      Serial.begin(9600);
      delay(200);
      Serial.write(digitalRead(7));
      Serial.end();
    } else {
      String status = "";
      if (digitalRead(7) == HIGH){
        status = "1";
      } else {
        status = "0";
      }
      Serial.print(status);
      Serial.end();
    }
  } else {
    String status = "";
    if (digitalRead(7) == HIGH){
      status = "1";
    } else {
      status = "0";
    }
    Serial.print(status);
    Serial.end();
  }
}
