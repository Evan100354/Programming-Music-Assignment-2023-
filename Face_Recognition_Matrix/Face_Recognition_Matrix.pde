import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup() 
{
  size(1000, 1000);
  colorMode(HSB);
  
  cam = new Capture(this, 1000 / 2, 1000 / 2);
  opencv = new OpenCV(this, 1000 / 2, 1000 / 2);
  cam.start();
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  
  minim = new Minim(this);
  ap = minim.loadFile("EnterTheDragon.mp3");
  ap1 = minim.loadFile("SelfMedication.mp3");
  ap2 = minim.loadFile("Mahler.mp3");
  ai = minim.getLineIn(Minim.MONO, bufferSize, 44100, 16);
    
  fft = new FFT(bufferSize, 44100); 
}

Capture cam;
OpenCV opencv;

String welcome = "Welcome to the Matrix.";
String exit = "To leave, press ESC.";
String stay = "To continue to authorization, hold ENTER until you are in focus.";
String scan = "User Found. Scanning... Authorizing...";
String cont = "Authorization successful, press C to continue.";
String menu1 = "Welcome, User. ";
String menu2 = "To choose your visualizer, Press L, E, P or O."; 

float rectMove = 0;
float rectMove1 = 0;

boolean camScan = false;
boolean titleScreen = true;
boolean delayEnd = false;

float userNum = random(100000);
int userNumInt = floor(userNum);

Minim minim;
AudioInput ai;
AudioPlayer ap;
AudioPlayer ap1;
AudioPlayer ap2;
AudioBuffer ab;

FFT fft;

int bufferSize = 1024;
float lerpedAverage = 0;
float[] lerpedBuffer = new float[bufferSize];
float c = 0;


void draw() 
{
  if(titleScreen == true)
  {
    background(0);
    strokeWeight(0);
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
  
  if(camScan == true)
  {
    if(key == 'c')
    {
      background(0);
      textSize(20);
      fill(70, 255, 255);
      text(menu1 + userNumInt, 0, 50);
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
        float c = map(i, 0, ab.size(), 0, 255);
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
      
      float radius2 = 50 + (lerpedAverage * 1900);
      line(0, 0, radius2, radius2);
      line(width, 0, -(radius2) + width, radius2);
      line(0, height, radius2, -(radius2) + height);
      line(width, height, -(radius2) + width, -(radius2) + height);
      
      line(0, 0, radius2, radius2);
      line(250, 0, radius2, radius2);
      line(350, 0, radius2, radius2);
      line(650, 0, -(radius2) + width, radius2);
      line(750, 0, -(radius2) + width, radius2);
      line(250, height, radius2, -(radius2) + height);
      line(350, height, radius2, -(radius2) + height);
      line(650, height, -(radius2) + width, -(radius2) + height);
      line(750, height, -(radius2) + width, -(radius2) + height);
      
      line(0, 250, radius2, radius2);
      line(0, 350, radius2, radius2);
      line(0, 650, radius2, -(radius2) + height);
      line(0, 750, radius2, -(radius2) + height);
      line(1000, 250,-(radius2) + width, radius2);
      line(1000, 350,-(radius2) + width, radius2);
      line(1000, 650,-(radius2) + width, -(radius2) + height);
      line(1000, 750, -(radius2) + width, -(radius2) + height);
      
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
      float qH = height/4;
      float total = 0;
      for (int i = 0 ; i < ab.size(); i ++)
      {
        total += abs(ab.get(i));
        float c = map(i, 0, ab.size(), 122.5, 255);
        stroke(c, 255, 255);
        lerpedBuffer[i] = lerp(lerpedBuffer[i], ab.get(i), 0.1f);
        line(i / 3, qH, i / 3, qH + (lerpedBuffer[i] * halfH * 2));
        line(-(i / 3) + width, qH, -(i / 3) + width, qH + (lerpedBuffer[i] * halfH * 2));
        line(i / 3, qH+500, i / 3, (qH+500) + (lerpedBuffer[i] * halfH * 2));
        line(-(i / 3) + width, qH+500, -(i / 3) + width, (qH+500) + (lerpedBuffer[i] * halfH * 2));
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
      float radius1 = 20 + (lerpedAverage * 450)*-1;
      triangle(radius*2, halfH, halfW, halfH+100, halfW, halfH);
      triangle(halfW, radius*2, halfW, halfH+100, radius*2, halfH);
      triangle(radius1*2+925, halfH, halfW, radius1*2+925, halfW, halfH);
      triangle(halfW, halfH, halfW, halfH-100, radius1*2+925, halfH);
      
      float radius2 = 50 + (lerpedAverage * 1750);
      line(250, 0, radius2, radius2);
      line(750, 0, -(radius2) + width, radius2);
      line(250, height, radius2, -(radius2) + height);
      line(750, height, -(radius2) + width, -(radius2) + height);
      line(350, 0, radius2, radius2);
      line(650, 0, -(radius2) + width, radius2);
      line(350, height, radius2, -(radius2) + height);
      line(650, height, -(radius2) + width, -(radius2) + height);
      
      line(0, 250, radius2, radius2);
      line(0, 750, radius2, -(radius2) + height);
      line(1000, 250,-(radius2) + width, radius2);
      line(1000, 750, -(radius2) + width, -(radius2) + height);
      line(0, 350, radius2, radius2);
      line(1000, 650,-(radius2) + width, -(radius2) + height);
      line(1000, 350,-(radius2) + width, radius2);
      line(0, 650,  radius2, -(radius2) + height);
    }
  }
  
  delay();
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
      fill(0);
      text(scan, faces[i].x, faces[i].y - 10);
    }
  }
}

void captureEvent(Capture c) 
{
  c.read();
}

void delay()
{
  if(camScan == true && delayEnd == false)
  {
    delay(5000);
    fill(0);
    rect(200, 450, 600, 100);
    
    textSize(30);
    fill(70, 255, 255);
    text(cont, 210, 520);
    delayEnd = true;
  }
}
