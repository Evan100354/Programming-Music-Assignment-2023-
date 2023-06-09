//WE WANT TO KILL OURSELVESSSSSSS!!!!!!!!!!!!!!!!!!!!!!!!

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

ArrayList<Cube> cubes = new ArrayList<Cube>();

int numCubes = 0;

void keyPressed()
{
  if(key > '0' && key < '9')
  {
    numCubes = key - '0';
    makeCubes(numCubes);
  }
}

void makeCubes(int count)
{
  cubes.clear();
  float halfW = width / 2;
  float halfH = height / 2;
  float radius = 500;
  
  for(int i = 0 ; i < count ; i ++)
  {
    float theta = map(i, 0, count, 0, TWO_PI);
    float x = halfW + sin(theta) * radius;
    float y = halfH - cos(theta) * radius;
    
    Cube cube = new Cube(0, 0, 0, x, y);
    cubes.add(cube);
    
  }
}

void setup()
{
 //size(512, 500, P3D);
 fullScreen(P3D);
 colorMode(HSB);
 
 //cube = new Cube(100, 0.1f, color(100, 255, 255), width / 2, height / 2);
 //cube1 = new Cube(100, 0.05f, color(200, 255, 255), width / 4, height / 4);
 
 minim = new Minim(this);
 ai = minim.getLineIn(Minim.MONO, 512, 44100, 16);
 ap = minim.loadFile("spotifydown.com - 3zuctAWbLpN3yvheYm0SZY.mp3");
 ap.play();
 ab = ap.mix;
 
}

float theta;
Cube cube;
Cube cube1;

Minim minim;
AudioPlayer ap;
AudioInput ai;
AudioBuffer ab;

float average = 0;
float lerpedAverage = 0;

void draw()
{
  float total = 0;
  for(int i = 0 ; i < ab.size() ; i ++)
  {
    total += abs(ab.get(i));
  }
  average = total / (float) ab.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  
  background(0);
  
  lights();
  theta += map(mouseX, 0, width, 0, 0.1f);
  
  for(int i = 0 ; i < cubes.size() ; i ++)
  {
    Cube cube = cubes.get(i);
    cube.c = color(map(lerpedAverage, 0.0f, 1.0f, 0, 255), 255, 255);
    cube.speed = map(lerpedAverage, 0.0f, 1.0f, 0, 0.2);
    cube.size = map(lerpedAverage, 0, 1, 300, 600);
    cube.update();
    cube.render();
  }
  
  
  //cube1.update();
  //cube1.render();
}
