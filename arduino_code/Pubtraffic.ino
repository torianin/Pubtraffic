/*

Robert Ignasiak Pubtraffic.pl 2012

 */

unsigned int RDIF_value;
unsigned int index = 0;

void setup() {
  Serial.begin(9600);   
  pinMode(2, INPUT);  
  pinMode(13, OUTPUT);     
}

void loop() {
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
      Serial.println();
      digitalWrite(13, LOW);
      delay(5000);
    }
  }
}
