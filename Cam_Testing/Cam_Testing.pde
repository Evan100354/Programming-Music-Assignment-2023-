import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture cam;
OpenCV opencv;
boolean camScan = false;
boolean titleScreen = true;
boolean delayEnd = false;

String cont = "Press C to continue";

void setup()
{
  size(1000, 1000);
  colorMode(HSB);
  
  cam = new Capture(this, 1000 / 2, 1000 / 2);
  opencv = new OpenCV(this, 1000 / 2, 1000 / 2);
  cam.start();
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw()
{  
  if(titleScreen == true)
  {
    background(0);
  }
  
  if(keyPressed == true)
  {
    if(key == ENTER)
    {
      if(cam.available())
      {
        cam.read();
      }
      image(cam, 0, 0);
      
      scale(2);
      opencv.loadImage(cam);
      
      image(cam, 0, 0 );
    }
  }
  
  if(key == 'c')
  {
    background(255);
  }
  
  delay();
}

void captureEvent(Capture c) 
{
  c.read();
}

void keyReleased()
{
  if(key == ENTER)
  {
    titleScreen = false;
    Rectangle[] faces = opencv.detect();
      
    noFill();
    stroke(70, 255, 255);
    strokeWeight(3); 
    
    for (int i = 0; i < faces.length; i++) 
    {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      camScan = true;
    }
    for (int i = 0; i < faces.length; i++) 
    { 
      textSize(15);
      fill(70, 255, 255);
      text("Scanning....", faces[i].x, faces[i].y - 10);
    }
  }
}

void delay()
{
  if(camScan == true && delayEnd == false)
  {
    delay(2000);
    fill(0);
    rect(200, 450, 600, 100);
    
    textSize(40);
    fill(70, 255, 255);
    text(cont, 220, 495);
    delayEnd = true;
  }
}
