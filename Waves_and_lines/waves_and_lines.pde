import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

void setup()
{
  //fullScreen();
  size(1024, 1024);
  
  minim = new Minim(this);
  
  ap = minim.loadFile("spotifydown.com - 3zuctAWbLpN3yvheYm0SZY.mp3");
  ai = minim.getLineIn(Minim.MONO, bufferSize, 44100, 16);
  ab = ap.mix;
  ap.play();
    
  fft = new FFT(bufferSize, 44100); 
}

Minim minim;
AudioInput ai;
AudioPlayer ap;
AudioBuffer ab;

FFT fft;

int bufferSize = 1024;
float lerpedAverage = 0;
float[] lerpedBuffer = new float[bufferSize];
float c = 0;


void draw()
{
  background(0);
  colorMode(HSB);
  noFill();
  strokeWeight(1);
  //if(keyPressed == true)
  {
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
  //else
  {
    //println("slay");
  }
}
