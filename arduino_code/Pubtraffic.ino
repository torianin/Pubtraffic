/*

Robert Ignasiak Pubtraffic.pl 2012

 */

unsigned int RDIF_value;
unsigned int index = 0;
int buttonState = 0;
int buttonState2 = 0;

unsigned int pub = 1;

void setup() {
  Serial.begin(9600);   
  pinMode(2, INPUT);  
  pinMode(4, INPUT);  
  pinMode(8, OUTPUT);    
  pinMode(12, OUTPUT);    
  pinMode(13, OUTPUT);    
}

void loop() {
  buttonState = digitalRead(2);
  if (buttonState == HIGH) {     
     pub = 1; 
  }
  
  buttonState2 = digitalRead(4);
  if (buttonState2 == HIGH) {     
     pub = 2; 
  }
  
  switch (pub) {
    case 1:
      digitalWrite(12, HIGH);
      digitalWrite(8, LOW);
      break;
    case 2:
      digitalWrite(8, HIGH);
      digitalWrite(12, LOW);
      break;
  }

  digitalWrite(13, HIGH);
  if (Serial.available() > 0){
    if (index<12){
      RDIF_value = Serial.read();
      if ( RDIF_value > 32){
        Serial.write(RDIF_value);    
        index++;
        }
    }else{
      index = 0;
      Serial.print(pub); 
      Serial.println();
      digitalWrite(13, LOW);
      delay(5000);
    }
  }
}