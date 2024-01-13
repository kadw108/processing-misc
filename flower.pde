float noiseFill(float x, float y, float scatterFac) {
    float n = noise(x + random(0, scatterFac), y + random(0, scatterFac), random(0, 1000));
    if (n < 0.7) {
      n = 0;
    } else {
      n = 1;
    }
    return n;
}

/* 
 * Draws a flower.
 * YOU CANNOT ROTATE THIS FLOWER. DO NOT TRY. YOU NEED TO REWRITE THE CODE FROM THE GROUND UP TO ROTATE IT.
 * I HAVE WASTED HOURS TRYING TO DO THIS.
 *
 * x - x of flower bottom
 * y - y of flower bottom
 * petals - number of petals, always odd, automatically adds 1 if even number
 * size - size of flower's petals in pixels (best to make it small)
 * len - len of petals, on scale of 1 = 100%
 * deg - arc of circle that petals should span, measured in degrees
 *
 * 
 */
void flower(PGraphics pg, float x, float y, int petals, float size, float len, float deg, float yShift, float xShift) {
  pg.pushMatrix();
  pg.translate(x, y);

  for (int i = petals/2; i >= 0; i--) { // non overlapping petals
  // for (int i = 0; i <= petals/2; i++) { // overlapping petals

    petal(pg, size + yShift, xShift, size, 180, len, -90 + i * deg/petals);
    petal(pg, size + yShift, xShift, size, 180, len, -90 + -i * deg/petals);
  }
  pg.popMatrix();
}
void flower(float x, float y, int petals, float size, float len) {
  flower(x, y, petals, size, len, 360);
}
void flower(float x, float y, int petals, float size, float len, float deg) {
  flower(g, x, y, petals, size, len, deg, 0, 0);
}
void flower(PGraphics pg, float x, float y, int petals, float size, float len, float deg) {
  flower(pg, x, y, petals, size, len, deg, 0, 0);
}

void petal(PGraphics pg, float x, float y, float radius, int npoints, float len, float deg) {
  pg.pushMatrix();
  pg.rotate(radians(deg));
  pg.scale(len, 1);
  
  float angle = TWO_PI / npoints;
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
      float radius2 = constrain((min(abs(a - PI), PI))*radius, radius, MAX_FLOAT);
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      pg.vertex(sx, sy);
  }
  pg.endShape(CLOSE);
  
  pg.popMatrix();
}
void petal(float x, float y, float radius, float len, float deg) {
  petal(g, x, y, radius, 360, len, deg);
}

// from https://openprocessing.org/sketch/242725

/*
ArrayList petal = new ArrayList();

void setup() {
  size(900, 600);

  // Add 50 petals
  for (int i = 0; i < 50; i++) {
    petal.add(new Petal());
  }
}

void draw() {
  fill(255, 30);
  rect(-20, -20, width+20, height+20);

  for (int i = 0; i < petal.size (); i++) {
    Petal p = (Petal) petal.get(i);
    p.draw();
    p.boundaries();
  }
}
*/

class Petal {
  PVector loc;
  PVector vel;
  //add wiggling  
  float s = random(-10, 10);
  float petalSize = random(0.15, 0.55);

  Petal() {
    //petals' location
    loc = new PVector(random(width), random(height));
    //petals moving track
    vel = new PVector(random(0, 2), random(-1, 1)+2);
  }

  void draw() {
    strokeWeight(1);
    strokeJoin(ROUND);
    stroke(180+mouseX, 130, 200, 25+(loc.y+loc.x)/40);
    fill(180+mouseX, 130, 180, 5+(loc.y+loc.x)/50);

    loc.add(vel);
    pushMatrix();
    translate(loc.x, loc.y);
    scale(petalSize);
    rotate(vel.heading2D()-radians(120));
    beginShape();

    //make petal from two sin lines
    for (int i = 0; i <= 180; i+=10) {
      float x = sin(radians(i)) * i/2;
      float angle = sin(radians(i+s+frameCount*4)) * loc.x/15;
      vertex(x-angle, i*2);
      vertex(x-angle, i*2);
    }

    for (int i = 180; i >= 0; i-=5) {
      float x = sin(radians(i)) * i/2;
      float angle = sin(radians(i+s+frameCount*4)) * loc.y/20;
      vertex(-x-angle, i*2);
      vertex(-x-angle, i*2);
    }
    endShape();
    popMatrix();
  }

  void boundaries() {
    if (loc.x < -50) loc.x = width+50;
    if (loc.x > width+50) loc.x = -50;
    if (loc.y < -50) loc.y = height+50;
    if (loc.y > height+50) loc.y = -50;
  }
}
