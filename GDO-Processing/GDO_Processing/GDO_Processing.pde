import processing.serial.*;
import processing.net.*;
 
Client c;Serial ComPort;
String input[];
JSONObject json;
String status;
String statusRaw;

void setup() {
  String portName = Serial.list()[0];
  ComPort = new Serial(this, portName, 9600);
  ComPort.bufferUntil('\n');
}

void draw() {
  input = loadStrings("http://192.168.0.15:51112/Commands/commands.txt"); 
  if (input != null && input.length != 0) {
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

     statusRaw = ComPort.readString();
     if (statusRaw == "1") {
       status = "Closed";
     } else {
       status = "Open";
     }
     
     c = new Client(this, "http://192.168.0.15:51112/api/GDO/SendDoorStatus/" + status, 80);
     c.write("GET / HTTP/1.0\r\n");
     c.write("\r\n");
  }
}