import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture cam;
OpenCV opencv;
boolean camScan = false;

void setup()
{
  size(1000, 1000);
  cam = new Capture(this, 1000 / 2, 1000 / 2);
  opencv = new OpenCV(this, 1000 / 2, 1000 / 2);
  cam.start();
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw()
{
  background(0);
  if(keyPressed == true)
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
  
  if(camScan == true)
  {
    println("test");
  }
}

void captureEvent(Capture c) 
{
  c.read();
}

void keyReleased()
{
  if(key == ENTER)
  {
    Rectangle[] faces = opencv.detect();
      
    noFill();
    stroke(70, 255, 255);
    strokeWeight(3); 
    
    for (int i = 0; i < faces.length; i++) 
    {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    for (int i = 0; i < faces.length; i++) 
    { 
      textSize(15);
      fill(70, 255, 255);
      text("Scanning....", faces[i].x, faces[i].y - 10);
    }
    camScan = true;
  }
}
