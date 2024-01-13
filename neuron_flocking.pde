// based on https://processing.org/examples/flocking.html

void neuron(PGraphics pg, float seed, float size, float x, float y, color c, boolean glow) {
    if (size < 10) {
        pg.strokeWeight(1);
    }
    else {
        pg.strokeWeight(2);
    }
    pg.stroke(c);

    float rectLen = size;
    float rectWidth = size * (2.0/3);

    if (glow) {
        pg.rect(x - rectWidth/2, y - rectLen, rectWidth, rectLen, 10);
        pg.filter(BLUR, 3);
        pg.noFill();
    }
    else {
        pg.fill(lerpColor(c, #ffffff, 0.5));
    }

    // rounded corner (radius) rectangle
    // pg.rect(x - rectWidth/2, y - rectLen, rectWidth, rectLen, 10);
    // attempt at more 'neuron'-like shape
    pg.beginShape();
    pg.vertex(x, y);
    pg.curveVertex(x, y);
    // pg.curveVertex(x - rectWidth/2, y);
    pg.curveVertex(x - rectWidth/2, y - rectLen/4);
    // pg.curveVertex(x - rectWidth/2, y - rectLen/2 - rectLen/3);
    pg.curveVertex(x - rectWidth/2, y - rectLen - rectLen/5);
    pg.curveVertex(x, y - rectLen - rectLen/2 - rectLen/4);
    pg.curveVertex(x + rectWidth/2, y - rectLen - rectLen/5);
    // pg.curveVertex(x + rectWidth/2, y - rectLen/2 - rectLen/3);
    pg.curveVertex(x + rectWidth/2, y - rectLen/4);
    // pg.curveVertex(x + rectWidth/2, y);
    pg.curveVertex(x, y);
    pg.vertex(x, y);
    pg.endShape();

    pg.noStroke();
    pg.fill(#ffffff);
    pg.rect(x - rectWidth/4, y - rectLen, rectWidth/3, rectLen/3, 10);

    /* DRAW TAILS */
    y -= rectLen * 0.2;

    // PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
    PVector[] tail1 = randomCurve(rectLen * 1.5, 2, 270, 90, seed);
    PVector[] tail2 = randomCurve(rectLen * 1.5, 2, 270, 90, seed + 10);

    pg.noFill();
    pg.stroke(c);

    // tail 1
    pg.beginShape();
    pg.curveVertex(x, y); // 1st control point
    for (int i = 0; i < tail1.length; i++) {
        pg.curveVertex(x + tail1[i].x, y + tail1[i].y);
    }
    pg.curveVertex(x + tail1[tail1.length - 1].x, y + tail1[tail1.length - 1].y); // last control point
    pg.endShape();
  

    // tail 2
    pg.beginShape();
    pg.curveVertex(x, y); // 1st control point
    for (int i = 0; i < tail2.length; i++) {
        pg.curveVertex(x + tail2[i].x, y + tail2[i].y);
    }
    pg.curveVertex(x + tail2[tail2.length - 1].x, y + tail2[tail2.length - 1].y); // last control point
    pg.endShape();
}

// The FlockParticle class

class FlockParticle {
  int seed;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  FlockParticle(float x, float y) {
    seed = (int) random(1000);

    acceleration = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<FlockParticle> FlockParticles, PGraphics pg) {
    flock(FlockParticles);
    update();
    borders();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<FlockParticle> FlockParticles) {
    PVector sep = separate(FlockParticles);   // Separation
    PVector ali = align(FlockParticles);      // Alignment
    PVector coh = cohesion(FlockParticles);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render(PGraphics pg) {
    // Draw a neuron rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    
    pg.pushMatrix();
    pg.translate(position.x, position.y);
    pg.rotate(theta);
    /*
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    */

    // void neuron(PGraphics pg, float seed, float x, float y) {
    neuron(pg, frameCount/frameRateConst * 0.1 + seed, 6,
        0, 0,
        lerpColor(#ff0000, #aa00ff, position.x/width), false);

    pg.popMatrix();
  }

  void glow(PGraphics pg) {
    pg.fill(lerpColor(#66ccff, #aa00ff, position.x/width), 180);
    pg.noStroke();
    pg.circle(position.x, position.y, 20);
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby FlockParticles and steers away
  PVector separate (ArrayList<FlockParticle> FlockParticles) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every FlockParticle in the system, check if it's too close
    for (FlockParticle other : FlockParticles) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby FlockParticle in the system, calculate the average velocity
  PVector align (ArrayList<FlockParticle> FlockParticles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (FlockParticle other : FlockParticles) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby FlockParticles, calculate steering vector towards that position
  PVector cohesion (ArrayList<FlockParticle> FlockParticles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (FlockParticle other : FlockParticles) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
}

// The Flock (a list of FlockParticle objects)

class Flock {
  ArrayList<FlockParticle> FlockParticles; // An ArrayList for all the FlockParticles

  Flock() {
    FlockParticles = new ArrayList<FlockParticle>(); // Initialize the ArrayList
  }

  // split the run/render functions
  void run(PGraphics pg) {
    for (FlockParticle b : FlockParticles) {
      b.run(FlockParticles, pg);  // Passing the entire list of FlockParticles to each FlockParticle individually
    }
  }

  void render(PGraphics pg) {
    for (FlockParticle b : FlockParticles) {
      b.render(pg);
    }
  }

  void glow(PGraphics pg) {
    for (FlockParticle b : FlockParticles) {
      b.glow(pg);
    }
  }

  void addFlockParticle(FlockParticle b) {
    FlockParticles.add(b);
  }

}
