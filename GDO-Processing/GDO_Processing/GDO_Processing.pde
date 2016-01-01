import processing.serial.*;
Serial ComPort;
String input[];
JSONObject json;

void setup(){
  String portName = Serial.list()[0];
  ComPort = new Serial(this, portName, 9600);
  ComPort.bufferUntil('\n');
}

void draw(){
  input = loadStrings("http://192.168.0.15:51112/Commands/commands.txt"); 
  if (input != null && input.length != 0){
   String s_last = input[0];
   delay(200);
   input = loadStrings("http://192.168.0.15:51112/Commands/commands.txt");
   if (input.length != 0) {
     String s_current = input[0];
     if (!s_current.equals(s_last)) {
         println("1:" + s_current + ".");
         println("2:" + s_last + ".");
         ComPort.write(s_current);
         println(s_current);
     } else {
       println("skip");
     }
   }
  }
}