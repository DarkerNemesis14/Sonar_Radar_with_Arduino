#include<Servo.h>;

const int trigPin = 5;
const int echoPin = 6;
const int servoPin = 9;

Servo rotator;

long duration;
int distance;
int startRange = 1;
int endRange = 179;


void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  rotator.attach(servoPin);
  Serial.begin(9600);
}

void loop() {
  for (int i=startRange; i<=endRange; i++) {
    rotator.write(i);
    delay(30);
    distance = distanceCal();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
  
  for (int i=endRange; i>=startRange; i--){
    rotator.write(i);
    delay(30);
    distance = distanceCal();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

int distanceCal() {
  int distance;
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin,LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration * .032 /2;
  return distance;
}
