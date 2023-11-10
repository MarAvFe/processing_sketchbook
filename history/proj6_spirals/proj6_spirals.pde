float r = 0;
float movement = 0.2;
float smallCircle = 30;
float bigCircle = 60;
float posX, posY;

void setup() {
  size(400, 400);
  background(10);
  smooth();
  noStroke();
}

void draw() {
  fill(0, 2);
  //rect(0,0,400,400);
  translate(width/2, height/2);
  posX = 30+r;
  posY = 10;
  fill(map(noise(r), 0, 1, 200, 255), map(r, -80, 200, 255, 100), map(noise(posX, posY),0,1,100,255), 50);
  rotate(r);
  float circle_size = map(noise(posX,posY,r), 0, 1, 5, 15);
  ellipse(posX, posY, circle_size, circle_size);
  r = r + movement;
  println(movement);

  if ( r > 200 || r < -80 ) {
    movement *=-1.1;
    //movement = -movement;
    smallCircle *= 0.8;
    bigCircle *= 0.8;
  }
}
