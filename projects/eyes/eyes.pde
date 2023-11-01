/**
 * Arctangent. 
 * 
 * Move the mouse to change the direction of the eyes. 
 * The atan2() function computes the angle from each eye 
 * to the cursor. 
 */
 
int cols, rows; // Number of columns and rows in the matrix
int spacing = 100; // Spacing between each position
int[][] positions; // 2D array to store positions
Eye[][] eyes;
Eye e1, e2, e3;
boolean SQUINTTOGGLE = false;
float noiseX, noiseY;

void setup() {
  size(800, 600);
  noStroke();
  noiseX = random(10); // Initialize the noise variables with random values
  noiseY = random(10);
  
  cols = (width / spacing)+1;
  rows = (height / spacing)+1;
  eyes = new Eye[cols][rows];
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      eyes[x][y] = new Eye(x * spacing, y * spacing, spacing); // Store x, y coordinates
      noiseX += 0.05;
      noiseY += 0.05;
    }
  }
}

void draw() {
  background(102);
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      eyes[x][y].update(mouseX, mouseY);
      eyes[x][y].display();
    }
  }
}

void mouseClicked() {
  SQUINTTOGGLE = !SQUINTTOGGLE;
}

class Eye {
  int x, y;
  int size;
  float angle = 0.0;
  boolean squint = true;
  color pupilColor, ballColor;
  
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
     // Use Perlin noise to generate color components
    float r = map(noise(noiseX), 0, 1, 0, 255);
    float g = map(noise(noiseY), 0, 1, 0, 255);
    float b = map(noise(noiseX + noiseY), 0, 1, 0, 255);
    //pupilColor = color(random(255), random(255), random(255));
    pupilColor = color(r,g,b);
    ballColor = color(255-int(random(100)));
    
 }

  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
    squint = SQUINTTOGGLE;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    fill(ballColor);
    ellipse(0, 0, size, size);
    rotate(angle);
    //fill(153, 204, 0);
    fill(pupilColor);
    float pupilHeight = size / 2;
    if (squint) {
      pupilHeight = pupilHeight / 2;
    }
    ellipse(size/4, 0, pupilHeight, size/2);
    popMatrix();
  }
}
