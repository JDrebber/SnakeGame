// adapted from Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// https://youtu.be/AaGK-fj-BAM

Snake s;
int scl = 20;
String status = "";
PVector food;
boolean gotFood;
boolean alive;

void setup() {
  size(600, 600);
  s = new Snake();
  alive = true;
  frameRate(10);
  setFoodLocation();
}

void draw() {
  background(51);
  
  //changes direction
  if (keyPressed==true && key=='w') {
    s.dir(0, -1);
  } else if (keyPressed==true && key=='s') {
    s.dir(0, 1);
  } else if (keyPressed==true && key=='d') {
    s.dir(1, 0);
  } else if (keyPressed==true && key=='a') {
    s.dir(-1, 0);
  }

  s.checkForPulse();
  s.update();
  s.show();

  gotFood = s.eat(food);

//sets new food location if the players eats the old food
  if (gotFood) {
    setFoodLocation();
  }

  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);

  status = "length: " + s.total;


  text(status, 500, 45);

//cheat to move the food to a more advantageous location
  if (keyPressed==true && key == 'l') {
    setFoodLocation();
  }

//alerts the player that they are dead
  if (alive==false) {
    text("You are Dead!", 250, 300);
    text("Press x to restart", 240, 340);
  }
  
  //resets the game
  if (keyPressed==true && key=='x' && alive==false) {
      s = new Snake();
  }


  // TODO: Extensions...
  //       3. after you do #2, give the user an option to
  //          restart the game (keyPress?)
  //       4. change any other parameters in the game (speed, size, colors, etc)
  //            - first tinker on your own
  //            - then ask a colleague if you need help or ideas
  //       Then replace this comment with one of your own.
}


void setFoodLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}


class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  

  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void checkForPulse() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        total = 0;
        alive = false;
        text("Score:   " + total, 252, 320);
        frameRate(0);
      }
    }
  }


  void update() {
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }

    x = x + xspeed*scl;
    y = y + yspeed*scl;

    x = constrain(x, 0, width-scl);
    y = constrain(y, 0, height-scl);
  }

  void show() {
    fill(255);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }

  int getTotal() {
    return total;
  }
}
