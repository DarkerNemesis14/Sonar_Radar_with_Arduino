import processing.serial.*;

Serial radar;

String ang="";
String distance="";
String data="";

int angle, dist;

void setup() {
  size(1920, 1080);
  radar = new Serial(this, "COM3", 9600);
  radar.bufferUntil('.');
  background(0);
}

void draw() {
  fill(0,5);
  noStroke();
  rect(0,0,width, height*0.93);
  
  noStroke();
  fill(0,255);
  rect(0,height*0.93, width, height);
  
  drawRadar();
  drawLine();
  drawObject();
}


void serialEvent (Serial myPort) {                                                     // starts reading data from the Serial Port
                                                                                      // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
      data = myPort.readStringUntil('.');
      data = data.substring(0,data.length()-1);
      
      int index1 = data.indexOf(",");                                                    
      ang= data.substring(0, index1);                                                 
      distance= data.substring(index1+1, data.length());                            
      
      angle = int(ang);
      dist = int(distance);
      System.out.println(angle);
}

void drawRadar()
{
    pushMatrix();
    noFill();
    stroke(10,255,10);        //green
    strokeWeight(3);
    
    translate(width/2,height-height*0.06);
    
    line(-width/2,0,width/2,0);
    
    arc(0,0,(width*0.5),(width*0.5),PI,TWO_PI);
    arc(0,0,(width*0.25),(width*0.25),PI,TWO_PI);
    arc(0,0,(width*0.75),(width*0.75),PI,TWO_PI);
    arc(0,0,(width*0.95),(width*0.95),PI,TWO_PI);
    
    line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
    line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
    line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
    line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
    line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
    
    stroke(175,255,175); 
    strokeWeight(1);
    line(0,0,(-width/2)*cos(radians(15)),(-width/2)*sin(radians(15)));
    line(0,0,(-width/2)*cos(radians(45)),(-width/2)*sin(radians(45)));
    line(0,0,(-width/2)*cos(radians(75)),(-width/2)*sin(radians(75)));
    line(0,0,(-width/2)*cos(radians(105)),(-width/2)*sin(radians(105)));
    line(0,0,(-width/2)*cos(radians(135)),(-width/2)*sin(radians(135)));
    line(0,0,(-width/2)*cos(radians(165)),(-width/2)*sin(radians(165)));

    popMatrix();
}

void drawLine() {
  
    pushMatrix();
    
    strokeWeight(9);
    stroke(0,255,0);
    translate(width/2,height-height*0.06); 
    
   line(0,0,(width/2)*cos(radians(angle)),(-width/2)*sin(radians(angle)));
   

    popMatrix();
    
}


void drawObject() {
  
    pushMatrix();
    
    strokeWeight(9);
    stroke(255,0,0);
    translate(width/2,height-height*0.06);
   
    float pixleDist = (dist/40.0)*(width/2.0);                        // covers the distance from the sensor from cm to pixels
    float pd=(width/2)-pixleDist;
    
             
    float x=-pixleDist*cos(radians(angle));
    float y=-pixleDist*sin(radians(angle));
    
    if(dist<=40)                                                  // limiting the range to 40 cms
    {                               
       //line(0,0,pixleDist,0);  
       line(-x,y,-x+(pd*cos(radians(angle))),y-(pd*sin(radians(angle))));
    }
    popMatrix();
}
