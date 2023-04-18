class Cube
{
  float size;
  float speed;
  float theta;
  color c;
  PVector pos;
  
  Cube()
  {
    this(100, 0, color(255, 255, 255), width / 2, height / 2);
  }
  
  Cube(float size, float speed, color c, float x, float y)
  {
    this.size = size; //Disambiguation
    this.speed = speed;
    theta = 0;
    this.c = c;
    this.pos = new PVector(x, y);
  }
  
  void update()
  {
    theta += speed;
  }
  
  void render()
  {
    pushMatrix();
    strokeWeight(5);
    noFill();
    stroke(c);
       
    translate(pos.x, pos.y);
    rotateX(theta);
    rotateY(theta);
    box(size);
    popMatrix();
  }
}
