import processing.serial.*;
import org.json.*;
import java.net.URL;
import java.net.HttpURLConnection;

Serial ComPort;
String input[];
JSONObject json;
String status;
String statusRaw;

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
   
   if (Comport.available() > 0){
     
     statusRaw = ComPort.readString();
     if (statusRaw == "1"){
       status = "Closed";
     } else {
       status = "Open";
     }
     URL url = new URL("http://192.168.0.15:51112/api/GDO/PostDoorStatus");
     HttpURLConnection conn = null;
     try {
       conn = (HttpURLConnection) url.openConnection();
       try {
         conn.setRequestMethod("POST");
         conn.setDoOutput(true);
         conn.setUseCaches(false);
         conn.setAllowUserInteraction(false);
         conn.setRequestProperty("Content-Type","text/xml");
       } 
       catch (Exception e) {
       }
          OutputStream out = conn.getOutputStream();
       json = new JSONObject();
       json.put("Status",status);
       
       try {
         OutputStreamWriter wr = new OutputStreamWriter(out);
         wr.write(json.toString());
         wr.flush();
         wr.close();
       }
       catch (IOException e) {}
       finally {
         if (out != null)
           out.close();
       }
        
     }
     catch (IOException e) {} 
     finally {  //in this case, we are ensured to close the connection itself
       if (conn != null)
         conn.disconnect();
     }
   }
   
}