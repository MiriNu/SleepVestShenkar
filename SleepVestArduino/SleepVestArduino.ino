//test
/* [IMPORTANT] PLEASE LOG THE UPDATES HERE :
 * v0.0 describing the function, skeleton for the script
 * 
 */


//TODO: implement connection (might be bluetooth) or connection to nodemcu, (might be serial connection)...to be determined
void setup() {
  // put your setup code here, to run once:

  Serial.begin(115200);//please dont change this, and also, don't use Serial.

}

void loop() {
  char str[3];
  fetchData(str);// this fetchs the data, keep it on the top of the loop
  
  
  

  delay(200);
  memset(str,0,sizeof(str));//this function must stay at the end of the loop.
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

//TODO: function for the activation of the led stipes, this takes in argument an Integer : 0 when you just woke up, max when you are about to sleep
void ledStripe(int level){
  
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



