class SideJumper
{
  PImage image;
  Position position;
  float direction;
  PVector velocity;
  float jumpSpeed;
  float walkSpeed;  
}

SideJumper oldGuy;
float left;
float right;
float up;
float down;

float gravity = .5;
int ground = 700;

boolean jumping = false;
final int jumpMax = 30;
int jumpCounter = 0;
boolean falling = false;





class Line {
  final int lineHeight = 10;
  final int lineRounding = 8;
  
  int x;
  int y;
  int w;
  
  public Line(int x, int y, int w) {
    this.x = x;
    this.y = y;
    this.w = w;
  }
  
  public void draw() {
    rect(x, y, w, lineHeight, lineRounding);     
  }
  
  public boolean check(int y) {
    return (y == this.y - lineHeight);
  }
  
}




final int numLines = 2;
Line[] lines = new Line[numLines];

void initLines() {
  lines[0] = new Line(300, 670, 80);
  lines[1] = new Line(200, 500, 100);
}

void drawLines() {
  for(int i = 0; i < numLines; i++) {
    lines[i].draw(); 
  }
}

boolean encounteredLineAt(int y) {
  boolean foundOne = false; 
  for(int i = 0; i < numLines; i++) {
     if(lines[i].check(y)) {
       foundOne = true; 
     }
   }
   return foundOne;
}



void setup()
{
  size(800, 800);
  frameRate(30);
  
  initLines(); //<>//
  drawLines(); 
  
  oldGuy = new SideJumper();
  oldGuy.image = loadImage("oldman_3.png");
  oldGuy.position = new Position(400, ground);
  oldGuy.direction = 1;
  oldGuy.velocity = new PVector(0,0);
  oldGuy.jumpSpeed = 10;
  oldGuy.walkSpeed = 4;
}


void draw()
{
  background(100);
  fill(50,50,50);
  rect(300,670,80,10,8);
  updateOldGuy();
  
  /*
  if(oldGuy.position.y < 620)
  {
    oldGuy.position.y = 690;
  }
  */
}




void updateOldGuy()
{
  if (oldGuy.position.y < ground)
  {
    oldGuy.velocity.y += gravity;
  }
  else
  {
    oldGuy.velocity.y = 0; 
  }
  
  //if (oldGuy.position.y >= ground && up != 0)
  if(jumping && jumpCounter < jumpMax)
  {
    oldGuy.velocity.y = -oldGuy.jumpSpeed;
    jumpCounter++;
  }
  
  if(jumpCounter == jumpMax) {
    jumping = false;
    falling = true;
    jumpCounter = 0;
  }
  
  if(falling) {
    if(encounteredLineAt(oldGuy.position.y)) {
      falling = false;
    }
  }
  
  //println(oldGuy.position.y);
  
  oldGuy.velocity.x = oldGuy.walkSpeed * (left + right);
  
  
  Position nextPosition = new Position(oldGuy.position.x, oldGuy.position.y);
  //nextPosition.add(oldGuy.velocity);
  
  
  
  // Check collision with edge of screen and don't move if at the edge
 float wall = 0;
  
  if (nextPosition.x > wall && nextPosition.x < (width - wall))
  {
    oldGuy.position.x = nextPosition.x;
  } 
  if (nextPosition.y > wall && nextPosition.y < (height - wall))
  {
    oldGuy.position.y = nextPosition.y;
  } 
  
  // See car example for more detail here.
  translate(oldGuy.position.x, oldGuy.position.y);
  //scale(oldGuy.direction, 1);
  imageMode(CENTER);
  image(oldGuy.image, 0, 0);
}

void keyPressed()
{
  if (key == 'd')
  {
    right = 1;
    oldGuy.direction = -1;
  }
  if (key == 'a')
  {
    left = -1;
    oldGuy.direction = 1;
  }
  if (key == ' ')
  {
    up = -1;
    jumping = true;
  }
  if (key == 's')
  {
    down = 1;
  }
}

void keyReleased()
{
  if (key == 'd')
  {
    right = 0;
  }
  if (key == 'a')
  {
    left = 0;
  }
  if (key == ' ')
  {
    up = 0;
  }
  if (key == 's')
  {
    down = 0;
  }
}
