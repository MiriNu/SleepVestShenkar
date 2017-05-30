
/* [IMPORTANT] PLEASE LOG THE UPDATES HERE :
 * v0.0 describing the function, skeleton for the script
 * 
 */


//TODO: implement connection (might be bluetooth) or connection to nodemcu, (might be serial connection)...to be determined

bool wakeUpNotification;
bool sleepNotification;
int ledLevel;


void setup() {
  // put your setup code here, to run once:

  Serial.begin(115200);//please dont change this, and also, don't use Serial.

}

void loop() {
  char str[3];
  fetchData(str);// this fetchs the data, keep it on the top of the loop
  sendData(); // sending data to nodeMCU
  
  
  

  delay(200);
  memset(str,0,sizeof(str));//this function must stay at the end of the loop.
  Serial.flush(); // remove any data that is pending in Serial
}



// TODO: Function to make noise to wake up (optional) :

void ring(){
  
}

//TODO : function to light leds in hood to wake up

void lightHood() {
  
}

//TODO: deflate the hood (open the valve for manual deflation, the valse should remain opened during all wake up time)

void deflateHood(){
  
}

//TODO : inflate the hood (we will have to experimentaly count the tie needed to inflate the hood and then set it in the function) :
void inflateHood() {
  
}

//TODO: function for the activation of the led stipes, this takes in argument an Integer between 0-9 : 0 when you just woke up, 9 when you are about to sleep
void ledStripe(int level){
  if (level > 9 || level < 0) {// making sure that the received value in in [0, 9]
    return;
  }
  
}

//TODO : this funtion sends a notification to check if person is up or not

bool isUp(){

}

// this function gets the data from the nodemcu

void fetchData(char str[]) {
  int i = 0;
  if (Serial.available()){
    delay(1);
    while (Serial.available()){
      str[i++] = Serial.read();
    }
    
  }
}

//function to send data

void sendData(){
  int thedata = 0;
  if (isUp()){
    thedata = 1;
  } 
  Serial.println(thedata);
}

// function to parse the incoming data to their respective values

void parse(char str[3]){
  wakeUpNotification = (str[0] == '1');
  sleepNotification = (str[1] == '1');
  ledLevel = str[2] - '0';
}



