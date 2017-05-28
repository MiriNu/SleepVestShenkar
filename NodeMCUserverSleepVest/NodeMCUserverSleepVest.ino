/*
 * 
 * this is a nodemcu script to interact with iphone app
 * 
 * 

*/


#include <ESP8266WiFi.h>
 
const char* ssid = "Home";
const char* password = "af12345678";

String state = "-1";
int ledPin = 13; // GPIO13
WiFiServer server(80);
 
void setup() {
  Serial.begin(115200);
  delay(10);
 
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
 
  // Connect to WiFi network
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
 
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
 
  // Start the server
  server.begin();
  Serial.println("Server started");
 
  // Print the IP address
  Serial.print("Use this URL to connect: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");
 
}
 
void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
 
  // Wait until the client sends some data
  while(!client.available()){
    delay(1);
  }
 
  // Read the first line of the request
  String request = client.readStringUntil('\r');
  
  client.flush();

 if (request != state){ // this is not to overload the nano with too much requests
  state = request.substring(5,8); 
  Serial.print(state);
 }
 
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println("");  
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
}
 
