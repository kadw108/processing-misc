/* ------------------------------- DYNAMIC LINES -------------------------------- */

// wavesHorizon - "horizon line", hSep - distance between lines
// image(althWaves(origin.y + 100, 10, 100), 0, 0);
PGraphics althWaves(float wavesHorizon, float hSep, float peakHeight) {
  // based on https://www.reddit.com/r/processing/comments/qtjwv7/thought_my_latest_project_was_worth_sharing/
  // by u/althazo
  
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  pg.stroke(255);
  pg.fill(0);
  
  for (int h = floor(wavesHorizon/hSep); h < height + 10; h++) {
    float lineHeight = h * hSep;
    
    pg.beginShape();
      // bottom side (top right, bot right, bot left, top left)
      pg.vertex(width + 10, lineHeight);
      pg.vertex(width + 10, height + 5);
      pg.vertex(-20, height + 5);
      pg.vertex(-20, lineHeight);
      
      // top side (curves)
      pg.curveVertex(0, lineHeight);
      
      PVector[] points = makeLineHor(width, 100);
      for (int i = 0; i < points.length; i++) {
        float heightPattern = sin((h + frameCount/frameRateConst) / 4);
        float peakAdd = - noise(i, h, frameCount/frameRateConst) * peakHeight * (1 - abs(origin.x - points[i].x)/origin.x) * exp(map(heightPattern, -1, 1, 0, 1));
        // negative for updir, peakheight is height, 1 - abs... decreases height as you leave center, exp(map) increases scale factor of height, heightPattern adds up-down sin waves
        
        pg.curveVertex(points[i].x, points[i].y + lineHeight + peakAdd + sin(i));
      }
      
      // ending curve vertex
      pg.curveVertex(width+5, lineHeight);
    pg.endShape(CLOSE);
  }
  
  pg.endDraw();
  return pg;
}

/* --------------------------------- SCROLLING/TILING ---------------------------------- */

// show tiling fullscreen: w/h is size of tile, x/ySpeed movement speed
PGraphics showTiling(PImage bg, float w, float h, float xSpeed, float ySpeed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float x = frameCount*xSpeed % width;
  float y = frameCount*ySpeed % height;
  
  int lowerX;
  int upperX;
  int lowerY;
  int upperY;
  if (ySpeed > 0) { // draw second image above
    lowerY = floor(-height/h);
    upperY = ceil(height/h);
  }
  else { // draw second image below
    lowerY = 0;
    upperY = ceil(2 * height/h);
  }
  if (xSpeed > 0) { // draw second image left
    lowerX = floor(-width/w);
    upperX = ceil(width/w);
  }
  else { // draw second image right
    lowerX = 0;
    upperX = 2 * ceil(width/w);
  }
  
  for (int i = lowerX; i < upperX; i++) {
    for (int j = lowerY; j < upperY; j++) {
      pg.image(bg, i*w + x, j*h + y, w, h);
    }
  }
  
  pg.endDraw();
  return pg;
}

PGraphics scrollBGDown(PImage bg, float speed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float y = frameCount*speed % height;
  pg.image(bg, 0, y);
  if (speed > 0) { // draw second image above
    pg.image(bg, 0, -bg.height + y);
  }
  else { // draw second image below
    pg.image(bg, 0, bg.height + y);
  }
  
  pg.endDraw();
  return pg;
}

PGraphics scrollBGSide(PImage bg, float speed) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float x = frameCount*speed % width;
  pg.image(bg, x, 0);
  if (speed > 0) { // draw second image left
    pg.image(bg, -bg.width + x, 0);
  }
  else { // draw second image right
    pg.image(bg, bg.width + x, 0);
  }
  
  pg.endDraw();
  return pg;
}

/* ------------------------------------- FULLSCREEN EFFECTS ------------------------------------------- */

/*
bg.mask(growCircles(100, 200, 255, 255));
image(bg, 0, 0);
*/
void growCircles(PGraphics pg, int num, float maxSize, color stroke, color fill) {
  pg.stroke(stroke);
  pg.fill(fill);
  
  for (int i = 0; i < num; i++) {
    float n = noise(i);
    // float n = noise(i, frameCount/frameRateConst); // can change to (int) ((frameCount % (i+1))/frameRateConst) or (int)(frameCount/frameRateConst)
    float xx = map(noise(i*5, i, n), 0, 1, -0.5, 1.5) * width;
    float yy = map(noise(i*i*5, n), 0, 1, -0.5, 1.5) * height;
    
    // can map to 0, 1 for always-on circles, etc
    float size = map(sin(noise(i, frameCount/frameRateConst) * TWO_PI * 1.5), -1, 1, -1, 1) * maxSize;
    
    if (size > 0) {
      pg.circle(xx, yy, size);
    }
  }
}

// static with rect
void staticBG(PGraphics pg, float h, color c1, color c2) {
  pg.noStroke();
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.fill(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.rect(0, i*h, width, h);
  }
}
// uses line instead of rect
void staticBG2(PGraphics pg, float h, color c1, color c2) {
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.line(0, i*h, width, i*h);
  }
}

// Draw grid with lines
void gridLines(PGraphics pg, float h, color c1, color c2, float speed, boolean horizontal) {
  float wh = pg.width;
  float n = random(0.3);

  if (horizontal) {
    /* Horizontal lines */
    float y = frameCount*speed % wh;
  
    for (int i = floor(-wh/h); i < wh/h; i++) {
      float yy = i*h + noise(i+frameCount/(float)frameRateConst)*(h/2) + y;
      // i*h is relative y, noise is stuttery effect, y is motion up/down
      
      pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
      pg.line(0, yy, wh, yy);
    }
  }
  else { // Vertical
    float x = frameCount*speed % wh;
  
    for (int i = floor(-wh/h); i < wh/h; i++) {
      float xx = i*h + noise(i+frameCount/(float)frameRateConst)*(h/2) + x;
      // i*h is relative y, noise is stuttery effect, x is motion left/right
      
      pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
      pg.line(xx, 0, xx, wh);
    }
  }
}

void textureRect(float x, float y, int w, int h, PImage texture, float textureSize) {
  PGraphics pg = createGraphics(w, h);
  pg.beginDraw();
  pg.background(#ffffff);
  pg.blendMode(DARKEST);
  pg.image(texture, 0, 0, textureSize, textureSize);
  pg.endDraw();
  
  image(pg, x, y);
}

/* ------------------------- WAVY SHAPES -------------------------------- */

void expandingShape(PGraphics pg, color c) {
    for (int i = 35; i > -1000; i -= 2) {
    float a = i + 3 * (float)frameCount / (frameRateConst);
    
    if (a > 0 && a < 40) {
      print(a, "\n");
      pg.fill(lerpColor(c, 0, a/35));
      waveShape(pg, origin.x, origin.y, a*30, a*36, 360, a);
    }
  }
}

/* 
  setFill(false);
  setStroke(255);
  setStrokeWeight(2);
  waveShape(g, origin.x, origin.y, 100, 130, 360, 0);
  */
void waveShape(PGraphics pg, float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff, 1.5 * (float)frameCount/(frameRateConst)), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    pg.vertex(x, y);
  }
  pg.endShape(CLOSE);
}

/* 
  setFill(false);
  setStroke(255);
  setStrokeWeight(2);
  waveShape(g, origin.x, origin.y, 100, 130, 360, 0);
  */
void waveShapeStill(PGraphics pg, float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  pg.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    pg.vertex(x, y);
  }
  pg.endShape(CLOSE);
}

/* ----------------------- */

// from Fall
PGraphics xCircle(float rad, float lineWidth, color c, boolean filter) {
  int w = ceil(rad*2 + max(100, lineWidth));
  
  PGraphics pg = createGraphics(w, w);
  PVector origin = new PVector(w/2, w/2);
  pg.beginDraw();
  
  pg.noFill();
  if (filter) {
    pg.strokeWeight(lineWidth * 1.25);
  }
  else {
    pg.strokeWeight(lineWidth);
  }
  pg.stroke(c);
 
  pg.ellipse(origin.x, origin.y, rad*2, rad*2);

  float rad_x = rad - lineWidth/2.0; 
  pg.line(origin.x + rad_x * cos(QUARTER_PI), origin.y + rad_x * sin(QUARTER_PI), origin.x + rad_x * cos(PI + QUARTER_PI), origin.y + rad_x * sin(PI + QUARTER_PI));
  pg.line(origin.x + rad_x * cos(HALF_PI + QUARTER_PI), origin.y + rad_x * sin(HALF_PI + QUARTER_PI), origin.x + rad_x * cos(-QUARTER_PI), origin.y + rad_x * sin(-QUARTER_PI));
  
  if (filter) {
    pg.filter(BLUR, 6);
  }
  
  pg.endDraw();
  
  return pg;
}
