import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Capture video;
OpenCV opencv;

void setup() 
{
  size(1000, 1000);
  colorMode(HSB);
  video = new Capture(this, 1000/2, 1000/2);
  opencv = new OpenCV(this, 1000/2, 1000/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
  
  minim = new Minim(this);
  
  ap = minim.loadFile("EnterTheDragon.mp3");
  ap1 = minim.loadFile("SelfMedication.mp3");
  ai = minim.getLineIn(Minim.MONO, bufferSize, 44100, 16);
    
  fft = new FFT(bufferSize, 44100); 
}

String welcome = "Welcome to the Matrix.";
String exit = "To Leave, Press ESC.";
String stay = "To Continue, Press ENTER...";
String scan = "Scanning... Press C to continue.";
String menu1 = "Welcome Back User.";
String menu2 = "To choose your selected soundtrack, Press L, E, P or O."; 

float rectMove = 0;
float rectMove1 = 0;


Minim minim;
AudioInput ai;
AudioPlayer ap;
AudioPlayer ap1;
AudioBuffer ab;

FFT fft;

int bufferSize = 1024;
float lerpedAverage = 0;
float[] lerpedBuffer = new float[bufferSize];
float c = 0;

void draw() 
{
  background(0);
  fill(70, 255, 255);
  textSize(20);
  text(welcome, 0, 50);
  text(exit, 0, 100);
  text(stay, 0, 150);
  
  fill(0);
  rect(rectMove, 0, 400, 60);
  rect(rectMove - 400, 60, 800, 60);
  rect(rectMove - 800, 110, 1300, 60);
  rectMove = rectMove + 2;
  
  
  if(key == ENTER)
  {
    scale(2);
    opencv.loadImage(video);
  
    image(video, 0, 0 );
  
    noFill();
    stroke(70, 255, 255);
    strokeWeight(3);
    
    Rectangle[] faces = opencv.detect();
  
    for (int i = 0; i < faces.length; i++) 
    {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    for (int i = 0; i < faces.length; i++) 
    { 
      fill(70, 255, 255);
      text(scan, faces[i].x, faces[i].y - 10);
    }
  }
  
  if(key == 'c')
  {
    background(0);
    fill(70, 255, 255);
    text(menu1, 0, 50);
    text(menu2, 0, 100);
    
    fill(0);
    noStroke();
    rect(rectMove1, 0, 400, 60);
    rect(rectMove1 - 400, 60, 1000, 60);

    rectMove1 = rectMove1 + 2;
  }
  
  if(key == 'l')
  {
    ap1.pause();
    ap1.rewind();
    
    ab = ap.mix;
    ap.play();
    background(0);
    noFill();
    strokeWeight(1);
    
    float halfH = height / 2;
    float halfW = width / 2;
    float total = 0;
    for (int i = 0 ; i < ab.size(); i ++)
    {
      total += abs(ab.get(i));
      float c = map(i, 0, ab.size(), 0, 120);
      stroke(c, 255, 255);
      lerpedBuffer[i] = lerp(lerpedBuffer[i], ab.get(i), 0.1f);
      line(i / 3, halfH, i / 3, halfH + (lerpedBuffer[i] * halfH * 2));
      line(-(i / 3) + width, halfH, -(i / 3) + width, halfH + (lerpedBuffer[i] * halfH * 2));
      line(halfW, i / 3, halfW + (lerpedBuffer[i] * halfW * 2), i / 3);
      line(halfW, -(i / 3) + height, halfW + (lerpedBuffer[i] * halfW * 2), -(i / 3) + height);
    }
    float average = total / (float) ab.size();
    
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
    
    c = c + 1;
    if(c >= 255)
    {
      c = 0;
    }
    
    strokeWeight(3);
    stroke(c, 255, 255);
    float radius = 20 + (lerpedAverage * 450);
    circle(halfW, halfH, radius * 2);
    circle(halfW, halfH, radius * 1.75);
    circle(halfW, halfH, radius * 1.5);
    circle(halfW, halfH, radius * 1.25);
    circle(halfW, halfH, radius * 1);
    circle(halfW, halfH, radius * 0.75);
    circle(halfW, halfH, radius * 0.5);
    circle(halfW, halfH, radius * 0.25);
    
    float radius2 = 50 + (lerpedAverage * 1750);
    line(0, 0, radius2, radius2);
    line(width, 0, -(radius2) + width, radius2);
    line(0, height, radius2, -(radius2) + height);
    line(width, height, -(radius2) + width, -(radius2) + height);
  }
  
  if(key == 'e')
  {
    ap.pause();
    ap.rewind();
    
    ab = ap1.mix;
    ap1.play();
    background(0);
    noFill();
    strokeWeight(1);
    
    float halfH = height / 2;
    float halfW = width / 2;
    float total = 0;
    for (int i = 0 ; i < ab.size(); i ++)
    {
      total += abs(ab.get(i));
      float c = map(i, 0, ab.size(), 0, 120);
      stroke(c, 255, 255);
      lerpedBuffer[i] = lerp(lerpedBuffer[i], ab.get(i), 0.1f);
      line(i / 3, halfH, i / 3, halfH + (lerpedBuffer[i] * halfH * 2));
      line(-(i / 3) + width, halfH, -(i / 3) + width, halfH + (lerpedBuffer[i] * halfH * 2));
      line(halfW, i / 3, halfW + (lerpedBuffer[i] * halfW * 2), i / 3);
      line(halfW, -(i / 3) + height, halfW + (lerpedBuffer[i] * halfW * 2), -(i / 3) + height);
    }
    float average = total / (float) ab.size();
    
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
    
    c = c + 1;
    if(c >= 255)
    {
      c = 0;
    }
    
    strokeWeight(3);
    stroke(c, 255, 255);
    float radius = 20 + (lerpedAverage * 450);
    circle(halfW, halfH, radius * 2);
    circle(halfW, halfH, radius * 1.75);
    circle(halfW, halfH, radius * 1.5);
    circle(halfW, halfH, radius * 1.25);
    circle(halfW, halfH, radius * 1);
    circle(halfW, halfH, radius * 0.75);
    circle(halfW, halfH, radius * 0.5);
    circle(halfW, halfH, radius * 0.25);
    
    float radius2 = 50 + (lerpedAverage * 1750);
    line(0, 0, radius2, radius2);
    line(width, 0, -(radius2) + width, radius2);
    line(0, height, radius2, -(radius2) + height);
    line(width, height, -(radius2) + width, -(radius2) + height);
  }
}

void captureEvent(Capture c) 
{
  c.read();
}
