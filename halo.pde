// halo

void star(PGraphics pg, float x, float y, float radius1, float radius2, int npoints, int shape) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  if (shape > 1) {
    pg.beginShape(shape); // QUADS, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUAD_STRIP
  } else {
    pg.beginShape();
  }
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    pg.vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    pg.vertex(sx, sy);
  }
  pg.endShape(CLOSE);
}
void star(float x, float y, float radius1, float radius2, int npoints, int shape) {
  star(g, x, y, radius1, radius2, npoints, shape);
}

void dots_star_recursive(PGraphics pg, float x, float y, float radius1, float radius2, float dot_size, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > 2) {
      dots_star_recursive(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > 2) {
      dots_star_recursive(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
  }
}
void dots_star_recursive(float x, float y, float radius1, float radius2, float dot_size, int npoints) {
  dots_star_recursive(g, x, y, radius1, radius2, dot_size, npoints);
}

void dots_star_recursive2(PGraphics pg, float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
  }
}
void dots_star_recursive2(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  dots_star_recursive2(g, x, y, radius1, radius2, dot_size, npoints, npoints_limit);
}

void dots_star_recursive3(PGraphics pg, float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit, float dot_size_small) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > dot_size_small && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > dot_size_small && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints/2, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
  }
}
void dots_star_recursive3(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit, float dot_size_small) {
  dots_star_recursive3(g, x, y, radius1, radius2, dot_size, npoints, npoints_limit, dot_size_small);
}


void dots_star_recursive4(PGraphics pg, float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    if (dot_size > 1 && npoints > npoints_limit) {
      dots_star_recursive2(pg, sx, sy, dot_size, dot_size, dot_size/4, npoints, npoints_limit);
    }
    else {
      pg.ellipse(sx, sy, dot_size, dot_size);
    }
  }
}
void dots_star_recursive4(float x, float y, float radius1, float radius2, float dot_size, int npoints, int npoints_limit) {
  dots_star_recursive4(g, x, y, radius1, radius2, dot_size, npoints, npoints_limit);
}

// Loads karma images from the file system.
PImage[] loadKarma() {
  String src = "../0rw_data/";
  PImage[] k = new PImage[10];
  for (int i = 1; i <= 10; i++) {
    k[i-1] = loadImage(src + "karma"+i+"_2.png");
  }
  return k;
}

/*
 * Shows a karma icon.
*/
void showKarmaIcon(float x, float y, float size, color c, int which, float deg) {
  showKarmaIcon(x, y, size, c, which, deg, g);
}

void showKarmaIcon(float x, float y, float size, color c, int which, float deg, PGraphics main) {
  main.imageMode(CENTER);
  main.tint(c, 255);
  
  main.pushMatrix();
  main.translate(x, y);
  main.rotate(radians(deg));
  main.image(karma[which], 0, 0, size, size);
  main.popMatrix();
  
  main.noTint();
  main.imageMode(CORNER);
}

/*
 * Shows karma as a ring.
 */
void showKarma(float x, float y, float radius1, float radius2, float deg, color c) {
  showKarma(x, y, radius1, radius2, 30, deg, c, main, false);
}

void showKarma(float x, float y, float radius1, float radius2, float deg, color c, PGraphics main) {
  showKarma(x, y, radius1, radius2, 30, deg, c, main, false);
}

void showKarma(float x, float y, float radius1, float radius2, float iconSize, float deg, color c, PGraphics main) {
  showKarma(x, y, radius1, radius2, iconSize, deg, c, main, false);
}

void showKarma(float x, float y, float radius1, float radius2, float iconSize, float deg, color c, PGraphics main, boolean blackCircle) {
  int npoints = 5;
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  int vertexnum = 0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;

    if (blackCircle == true) {
      main.circle(sx, sy, iconSize);
    }
    showKarmaIcon(sx, sy, iconSize, c, vertexnum, deg, main);
    vertexnum++;

    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;

    if (blackCircle == true) {
      main.circle(sx, sy, iconSize);
    }
    showKarmaIcon(sx, sy, iconSize, c, vertexnum, deg, main);
    vertexnum++;
  }
}

void outerKarmaRing(PGraphics pg, color c, float fC) {
  showKarma(0, 0, 300, 300, fC*2, c);

  // outer circle
  dots_star_recursive4(0, 0, 300, 300, ceil(abs(sin(((float)fC)/20))*15) + 30, 5, 1);
  // inner circle
  // dots_star_recursive4(0, 0, 300, 300, -5, 5, 2);
  // inner ring
  dots_star_recursive4(0, 0, 300, 300, 30, 5, 2);
}
void outerKarmaRing(color c) {
  outerKarmaRing(g, c, frameCount);
}
void outerKarmaRing(color c, float fC) {
  outerKarmaRing(g, c, fC);
}

/* FLOWER STAR
 * Flowers will always point up because I'm too lazy to write good code that lets you rotate them.
 * DO NOT TRY TO 'FIX' THIS ISSUE THERE IS NO EASY FIX IT'S HARDER THAN YOU THINK.
 *
 * x - x of center of ring
 * y - y of center of ring
 * radius1 - radius of one ring
 * radius2 - radius of second ring (=radius1 for circle shape, different for star shape)
 * flowerSize - size of flower, in pixels --- divided by 8 because the way we draw flowers makes them big
 * rotDeg - rotation of flowers in the ring
 * npoints - number of points in 'star', multiplied by 2 to get actual number of flowers
 *
 * Example: showFlower(origin.x, origin.y, 300, 300, 100, fC * 2, 5);
*/
void showFlower(PGraphics pg, float x, float y, float radius1, float radius2, float flowerSize, float rotDeg, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  flowerSize = flowerSize/8.0;
  
  for (float a = 0 + radians(rotDeg); a < TWO_PI + radians(rotDeg); a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    
    flower(pg, sx, sy, 5, flowerSize, 1.5, (map(sin(frameCount/(frameRateConst/3)), -1, 1, 0, 1)*225));
    
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    
    flower(pg, sx, sy, 5, flowerSize, 1.5, (map(sin(frameCount/(frameRateConst/3)), -1, 1, 0, 1)*225));
  }
}
void showFlower(float x, float y, float radius1, float radius2, float flowerSize, float rotDeg, int npoints) {
  showFlower(g, x, y, radius1, radius2, flowerSize, rotDeg, npoints);
}

void dots_star(PGraphics pg, float x, float y, float radius1, float radius2, int dot_size, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    pg.ellipse(sx, sy, dot_size, dot_size);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    pg.ellipse(sx, sy, dot_size, dot_size);
  }
}
void dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints) {
  dots_star(g, x, y, radius1, radius2, dot_size, npoints);
}

float theta;
// draw fractal tree, fC is frame count (for swaying branches)
void tree(int fC, float x, float y, float angle) {
  float fC3 = map(sin((float)fC/4), -1, 1, 6, 13);
  
  pushMatrix();
  // Convert it to radians
  theta = radians(fC3);
  // Start the tree from the bottom of the screen
  translate(x, y);
  rotate(radians(angle));
  
  // Draw a line 120 pixels, move to end of line
  int len = 60;
  line(0,0,0,-len);
  translate(0,-len);
  // Start the recursive branching!
  branch(len*3);
  popMatrix();
}
void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.7;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 20) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

// draw circle
void bubble(float x, float y, float w, float h) {
  ellipse(x, y, w * (y/height), h * (y/height));
}

// draw snow, size changes with position
void snow(float x, float y, float r1, float r2, int npoints) {
  posStar(x, y, r1 * constrain((height - y + height/2)/height, 0, 1), r2 * constrain((height - y + height/2)/height, 0, 1), npoints);
}

// draw ellipse or nothing if width or height < 0
void ellipsePos(PGraphics pg, float x, float y, float w, float h) {
  stroke(lerpColor(#56e2ff, #000000, ((float) w)/(1200)));
  if (w > 0 && h > 0) {
    ellipse(x, y, w, h);
    // ellipse(x, y, w + 5, h - 5);
  }
}
void ellipsePos(float x, float y, float w, float h) {
  ellipsePos(g, x, y, w, h);
}

void rotateCircle(PGraphics pg, int wid, int heit, int xShift, int yShift, int x, int y, float deg) {
  pushMatrix();
  translate(origin.x + x, origin.y + y);
  rotate(radians(deg));
  ellipse(xShift, yShift, wid, heit);
  popMatrix();
}
void rotateCircle(int wid, int heit, int xShift, int yShift, int x, int y, float deg) {
  rotateCircle(g, wid, heit, xShift, yShift, x, y, deg);
}

void star(PGraphics pg, float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    pg.vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    pg.vertex(sx, sy);
  }
  pg.endShape(CLOSE);
}
void star(float x, float y, float radius1, float radius2, int npoints) {
  star(g, x, y, radius1, radius2, npoints);
}

void custStar(PGraphics pg, float x, float y, float radius1, float radius2, int npoints, int cust) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  pg.beginShape(cust);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    pg.vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    pg.vertex(sx, sy);
  }
  pg.endShape(CLOSE);
}
void custStar(float x, float y, float radius1, float radius2, int npoints, int cust) {
  custStar(g, x, y, radius1, radius2, npoints, cust);
}

void posStar(float x, float y, float radius1, float radius2, int npoints) {
  if (radius1 > 0 && radius2 > 0) {
    star(x, y, radius1, radius2, npoints);
  }
  else {
    star(x, y, 1, 2, npoints);
  }
}

void rotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  posStar(0, 0, radius1, radius2, npoints);
  popMatrix();
}

void custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  
  if (radius1 > 0 && radius2 > 0) {
    custStar(0, 0, radius1, radius2, npoints, cust);
  }
  else {
    custStar(0, 0, 1, 2, npoints, cust);
  }
  
  popMatrix();
}

/*
 * Draws an ellipse of circles.
 */
void circleDots(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    pg.ellipse(sx, sy, radDot, radDot);
  }
}

/*
 * Draws an ellipse of circles, where every circleSpace circles, circleMissing circles will be missing.
 */
void circleDotsMissing(PGraphics pg, float x, float y, float radDot, float radX, float radY,
int npoints, int circleSpace, int circleMissing) {
  float angle = TWO_PI / npoints;
  int pattern = circleSpace + circleMissing;

  for (int i = 0; i < npoints; i++) {
    if (i % pattern < circleSpace) {
      float sx = x + cos(angle * i) * radX;
      float sy = y + sin(angle * i) * radY;
      pg.ellipse(sx, sy, radDot, radDot);
    }
  }
}

/*
 * Draws a circle of circles rotated deg degrees.
 */
void rotateCircleDots(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints, float deg) {
  pg.pushMatrix();
  pg.translate(origin.x + x, origin.y + y);
  pg.rotate(radians(deg));
  circleDots(pg, 0, 0, radDot, radX, radY, npoints);
  pg.popMatrix();
}

void circleStars(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints, int nStarPoints, float starDeg) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    rotatePosStar(sx, sy, radDot, radDot/4, nStarPoints, starDeg);
  }
}
void circleStars(float x, float y, float radDot, float radX, float radY, int npoints, int nStarPoints, float starDeg) {
  circleStars(g, x, y, radDot, radX, radY, npoints, nStarPoints, starDeg);
}

void rotateCircleStars(PGraphics pg, float x, float y, float radDot, float radX, float radY, int npoints, float deg, int nStarPoints) {
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(deg));
  circleStars(0, 0, radDot, radX, radY, npoints, nStarPoints, deg);
  pg.popMatrix();
}
void rotateCircleStars(float x, float y, float radDot, float radX, float radY, int npoints, float deg, int nStarPoints) {
  rotateCircleStars(g, x, y, radDot, radX, radY, npoints, deg, nStarPoints);
}

void polygon(PGraphics pg, float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
void polygon(float x, float y, float radius, int npoints) {
  polygon(g, x, y, radius, npoints);
}

// Swirl circle
void swirl(PGraphics pg, float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  float prevSX = x;
  float prevSY = y;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    pg.vertex(sx, sy);
    float sx2 = x + cos(a+halfAngle) * radius1;
    float sy2 = y + sin(a+halfAngle) * radius1;
    pg.vertex(sx, sy);
    
    pg.curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radius2*1.5), y + sin(a+10)*(radius2*1.5));
    // print(cos(a)*200, sin(a)*200, "\n");
    
    prevSX = sx;
    prevSY = sy;
  }
}
void swirl(float x, float y, float radius1, float radius2, int npoints) {
  swirl(g, x, y, radius1, radius2, npoints);
}

// Rotating swirl circle
void rotateSwirl(PGraphics pg, float x, float y, float radius1, float radius2, int npoints, float deg) {
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(deg));
  swirl(pg, 0, 0, radius1, radius2, npoints);
  pg.popMatrix();
}
void rotateSwirl(float x, float y, float radius1, float radius2, int npoints, float deg) {
  rotateSwirl(g, x, y, radius1, radius2, npoints, deg);
}

// Swirl ray circle with moving circumference (swirl rays)
void ellipseSwirlMoveRays(PGraphics pg, float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  // get sx and sy of last "curve" to use as ref for first curve
  float prevSX = 0;
  float prevSY = 0;
  for (float a = 0; a < TWO_PI; a += angle) {
    prevSX = x + cos(a+shift) * radx;
    prevSY = y + sin(a+shift) * rady;
  }
  
  // actually draw "curves" (triangles)
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    pg.curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radx*1.5), y + sin(a+10)*(rady*1.5));
    
    prevSX = sx;
    prevSY = sy;
  }
}
void ellipseSwirlMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  ellipseSwirlMoveRays(g, x, y, radx, rady, diff, npoints, shiftDeg);
}

// Ray circle with moving circumference (rays)
void ellipseMoveRays(PGraphics pg, float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    pg.line(sx, sy, sx2, sy2);
  }
}
void ellipseMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  ellipseMoveRays(g, x, y, radx, rady, diff, npoints, shiftDeg);
}

// Ray circle with weird rays, combination of prev. two
void ellipseTriMoveRays(PGraphics pg, float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  ellipseMoveRays(pg, x, y, radx, rady, diff, npoints, shiftDeg);
  ellipseSwirlMoveRays(pg, x, y, radx, rady, diff, npoints, shiftDeg);
}

// Ray circle with rectangles instead of lines as rays (5P style)
void ellipseRect(PGraphics pg, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    pg.pushMatrix();
    pg.translate(x, y);
    pg.rotate(a + shift);
    
    pg.rect(0, innerRad, rectW, diff);
    pg.popMatrix();
  }
}
void ellipseRect(float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {
  ellipseRect(g, x, y, innerRad, diff, rectW, npoints, shiftDeg);
}

// Ray circle with IMAGES instead of lines as rays (diff = height)
// ellipseImage(getFrame(karma, 0, (1/(float)20)), origin.x, origin.y, 300, 20, 20, 10, frameCount);
void ellipseImage(PGraphics pg, PImage img, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg, boolean flipImageVertically) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);

  if (flipImageVertically)  {
    innerRad *= -1;
  }

  for (float a = 0; a < TWO_PI; a += angle) {
    pg.pushMatrix();
    pg.translate(x, y);
    pg.rotate(a + shift);

    pg.image(img, 0, innerRad, rectW, diff);
    pg.popMatrix();
  }
}
void ellipseImage(PImage img, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {
  ellipseImage(g, img, x, y, innerRad, diff, rectW, npoints, shiftDeg, false);
}

// Like ellipseImage, but selects multiple images from the array to use at once
// ellipseImage(karma, origin.x, origin.y, 300, 20, 20, 10, frameCount);
void ellipseImageMultiple(PGraphics pg, PImage[] images, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg, boolean flipImageVertically, float seed) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);

  if (flipImageVertically)  {
    innerRad *= -1;
  }

  for (float a = 0; a < TWO_PI; a += angle) {
    pg.pushMatrix();
    pg.translate(x, y);
    pg.rotate(a + shift);

    int whichImage = floor(noise(seed, a) * images.length * 100);
    PImage img = getFrame(images, 0, whichImage);

    pg.image(img, 0, innerRad, rectW, diff);
    pg.popMatrix();
  }
}

void simpleMandalaRays(PGraphics pg, float x, float y, float radius1, float radius2, int numlines, float deg) {
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(deg));
  
  for (int i = 0; i < numlines; i++) {
    pg.line(-radius1, 0, radius2, radius2);
    pg.rotate(0.5);
  }
  
  pg.popMatrix();
}
void simpleMandalaRays(float x, float y, float radius1, float radius2, int numlines, float deg) { 
  simpleMandalaRays(g, x, y, radius1, radius2, numlines, deg);
}

void simpleMandalaEdge(PGraphics pg, float x, float y, float radius1, float radius2, int numlines, float deg) {
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(deg));
  
  for (int i = 0; i < numlines; i++) {
    pg.line(radius1/2, radius2/2, 0, radius1/2);
    pg.rotate(0.5);
  }
  
  pg.popMatrix();
}
void simpleMandalaEdge(float x, float y, float radius1, float radius2, int numlines, float deg) {
  simpleMandalaEdge(g, x, y, radius1, radius2, numlines, deg);
}


/*
Mandala formulations:
(i % radius2, 0, 0, 0); --- star, small rays from central point
(i % radius2, 0, 0, radius); --- default 2
(i % radius2, 0, radius, radius); --- default 1

(i % radius2, radius, 0, 0); --- sun, large rays from central point
(i % radius2, radius, 0, radius); --- eclipse, small rays from edge
(i % radius2, radius, radius, radius); --- large rays from edge

(i % radius2, 0, i % radius2, radius); --- default with starry points
*/

// https://www.openprocessing.org/sketch/504464
// Continually draw rays in circle pattern, origin (x, y)
int drawMandalaConst = 0;
void drawMandala(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandalaConst;
  drawMandalaConst += 3;
  
  while(i > 1){
    i--;
    // stroke(lerpColor(c, #000000, (i%255)/(float)255));
    stroke(c);
    line(i % radius2, 0, 0, radius);
    rotate(0.5);
  }
  
  popMatrix();
}

// https://www.openprocessing.org/sketch/504464
int drawMandala2Const = 0;
void drawMandala2(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandala2Const;
  drawMandala2Const++;
  
  while(i > 1){
    i--;
    stroke(lerpColor(c, #000000, (i%255)/(float)255));
    line(i % radius2, radius, i % radius2, radius2);
    rotate(1);
  }
  
  popMatrix();
}

// https://www.openprocessing.org/sketch/504464
int drawMandala3Const = 0;
void drawMandala3(float x, float y, float radius, float radius2, color c) {
  pushMatrix();
  translate(x, y);

  int i = drawMandala3Const;
  drawMandala3Const++;
  
  while(i > 1){
    i--;
    stroke(lerpColor(c, #ffffff, (i%255)/(float)255));
    line(i % radius2, radius, 0, 0);
    rotate(1);
  }
  
  popMatrix();
}

/*
Draw pie chart.
From https://processing.org/examples/piechart.html

pg - PGraphics to draw chart on, g for default
origin - origin of pie chart
diameter - diameter of pie chart
angles - array of angles where chart should be divided
startColor - one end of color range of pie chart slices
endColor - other end of color range of pie chart slices

Example: 

float[] angles = { 30, 10, 45, 35, 60, 38, 75, 67 };
pieChart(300, angles);
*/
void pieChart(PGraphics pg, PVector origin, float diameter, float[] angles, color startColor, color endColor) {
  float lastAngle = 0;
  for (int i = 0; i < angles.length; i++) {
    float colorDegree = float(i) / (angles.length - 1);
    color sliceColor = lerpColor(startColor, endColor, colorDegree);
    pg.fill(sliceColor);

    pg.arc(origin.x, origin.y, diameter, diameter, lastAngle, lastAngle + radians(angles[i]));
    lastAngle += radians(angles[i]);
  }
}