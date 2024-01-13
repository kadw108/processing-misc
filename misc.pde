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

// return points for horizontal line
PVector[] makeLineHor(float w, float sep) {
  PVector[] points = new PVector[ceil(w/sep) + 1];
  
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(i*sep, 0);
  }
  
  return points;
}

// return points for vertical line
PVector[] makeLineVer(float h, float sep) {
  PVector[] points = new PVector[ceil(h/sep) + 1];
  
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(0, -i*sep);
  }
  
  return points;
}
// len curve, sep between points, rotate = degrees of avg? rotation, defaultAngle is starting angle of line (degrees), noise seed
PVector[] randomCurve(float len, float sep, float rotate, float defaultAngle, float seed) {
  PVector[] points = new PVector[ceil(len/sep) + 1];
  
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  for (int i = 0; i < points.length; i++) {
    PVector n = PVector.fromAngle(radians(defaultAngle) + (noise(i, seed) - 0.5) * radians(rotate) * (10 * i/points.length));
    vel.add(n).setMag(sep);
    
    pos.add(vel);
    points[i] = new PVector(pos.x, pos.y);
  }
  
  return points;
}

void lineFromPoints(PVector[] points, float x, float y) {
  beginShape();
  curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    curveVertex(x + points[i].x, y + points[i].y);
  }
  curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  endShape();
}

// chainFromPoints(randomCurve(500, 2, 180, -90, noise(0.1 * frameCount/frameRateConst)), origin.x, origin.y, 40, 10);
void chainFromPoints(PVector[] points, float x, float y, float linkLen, float spaceBetween) { // TODO
  for (int i = 0; i < points.length; i++) {
    curveVertex(x + points[i].x, y + points[i].y);
  }
}

// image(fernField(1000, gold, gold, 1, height * (3.0/4), 600, 600), 0, 0);
PGraphics fernField(float stalkHeight, color stem, color leaf, int leafType, float fieldHorizon, float verSep, float horSep) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  for (int row = floor((fieldHorizon-verSep)/verSep); row < (height + verSep)/verSep; row++) {
    for (int col = -1; col < (width + horSep)/horSep; col++) {
      pg.pushMatrix();
      pg.translate(col*horSep + noise(row, col)*horSep*2, row*verSep);
      pg.scale(row/((height + verSep)/verSep));
      pg.rotate((noise(row/2, col/2, 0.3*frameCount/frameRateConst) - 0.5) * PI/4);
      pg.rotate(sin(0.6*frameCount/frameRateConst) * PI/10);
      fernFromPoints(pg, randomCurve(stalkHeight, max(2, stalkHeight/200), 180, -90, noise(row, col, 0.1 * frameCount/frameRateConst)), 0, 0, 3, leafType, stem, leaf);
      pg.popMatrix();
    }
  }
  pg.endDraw();
  return pg;
}
void fernFromPoints(PGraphics pg, PVector[] points, float x, float y, float leafSep, int leafType, color stem, color leafC) {
  
  // DRAW CENTER LINE - must be done individual from leaves
  pg.noFill();
  pg.strokeWeight(3);
  pg.stroke(stem);
  pg.beginShape();
  pg.curveVertex(x, y); // 1st control point
  for (int i = 0; i < points.length; i++) {
    pg.curveVertex(x + points[i].x, y + points[i].y);
  }
  pg.curveVertex(x + points[points.length - 1].x, y + points[points.length - 1].y); // last control point
  pg.endShape();
  
  // DRAW LEAVES
  boolean flipLeft = false;
  for (int i = 0; i < points.length; i++) {
    if (i % leafSep  == 0 && i > 0) {
      float posX = x + points[i].x;
      float posY = y + points[i].y;
      
      PShape leaf;
      float leafAngle = 0;
      stroke(leafC);
      // fill(leafC);
      switch (leafType) {
        case 0:
          leaf = fernLeafL(10, 10, 2);
          leafAngle = points[i].heading();
          break;
      
        case 1:
          leaf = fernLeafLance(10, 90, 2, 0);
          leafAngle = PI/4 + points[i].heading();
          break;
      
        case 2:
          leaf = fernLeafLine(20, 2, 0);
          leafAngle = PI/4 + points[i].heading();
          break;
          
        default:
          leaf = null;
          break;
      }
      
      if (leaf != null) {
        pg.pushMatrix();
        pg.translate(posX, posY);
        if (flipLeft) {
          pg.scale(-1, 1);
        }
        pg.rotate(leafAngle);
        pg.shape(leaf, 0, 0);
        pg.popMatrix();
        flipLeft = !flipLeft;
      }
    }
  }
}
PShape fernLeafL(float w, float h, float sep) {
  PShape shape = createShape();
  shape.beginShape();
  for (int i = 0; i < w/sep; i++) {
    shape.curveVertex(i*sep, 0);
  }
  for (int j = 0; j < h/sep; j++) {
    shape.curveVertex(w, - j * sep);
  }
  shape.endShape();
  return shape;
}
PShape fernLeafLine(float len, float sep, float seed) {
  PShape shape = createShape();
  shape.beginShape();
  for (int i = 0; i < len/sep; i++) {
    shape.curveVertex(i*sep, - noise(len, seed)*i*sep);
  }
  shape.endShape();
  return shape;
}
PShape fernLeafLance(float w, float len, float sep, float seed) { // lanceolate leaf
  PShape shape = createShape();
  shape.beginShape();
  
  // bottom side
  for (int i = 0; i < len/sep; i++) {
    shape.curveVertex(i*sep, map(sin(PI * i/(len/sep)), -1, 1, 0, 0.5) * w);
  }
  
  // top side
  for (int i = ceil(len/sep); i >= 0; i--) {
    shape.curveVertex(i*sep, map(sin(PI * i/(len/sep)), -1, 1, 0.5, 0) * w);
  }
  
  shape.endShape();
  return shape;
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
PGraphics growCircles(int num, float maxSize, color stroke, color fill) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  pg.stroke(stroke);
  pg.fill(fill);
  
  for (int i = 0; i < num; i++) {
    float n = noise(i);
    // float n = noise(i, frameCount/frameRateConst); // can change to (int) ((frameCount % (i+1))/frameRateConst) or (int)(frameCount/frameRateConst)
    float xx = map(noise(i*5, i, n), 0, 1, -0.5, 1.5) * width;
    float yy = map(noise(i*i*5, n), 0, 1, -0.5, 1.5) * height;
    
    // can map to 0, 1 for always-on circles, etc
    float size = map(sin(noise(i, frameCount/frameRateConst) * TWO_PI * 1.5), -1, 1, -3, 1) * maxSize;
    
    if (size > 0) {
      pg.circle(xx, yy, size);
    }
  }
  
  pg.endDraw();
  return pg;
}

// static with rect
PGraphics staticBG(float h, color c1, color c2) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  pg.noStroke();
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.fill(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.rect(0, i*h, width, h);
  }
  
  pg.endDraw();
  return pg;
}
// uses line instead of rect
PGraphics staticBG2(float h, color c1, color c2) {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  
  float n = random(0.3);
  for (int i = 0; i < height/h; i += random(2.02)) {
    pg.stroke(lerpColor(c1, c2, noise(i+frameCount*2 + n)));
    pg.line(0, i*h, width, i*h);
  }
  
  pg.endDraw();
  return pg;
}

// Draw grid with lines
PGraphics gridLines(float h, color c1, color c2, float speed, float strokeWidth, boolean horizontal) {
  int wh = max(width, height);
  
  PGraphics pg = createGraphics(wh, wh);
  pg.beginDraw();
  pg.strokeWeight(strokeWidth);
  
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
  
  pg.endDraw();
  return pg;
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

void expandingShape(color c) {
    for (int i = 35; i > -1000; i -= 2) {
    float a = i + 3 * (float)frameCount / (frameRateConst);
    
    if (a > 0 && a < 40) {
      print(a, "\n");
      fill(lerpColor(c, 0, a/35));
      waveShape(origin.x, origin.y, a*30, a*36, 360, a);
    }
  }
}
void waveShape(float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff, 1.5 * (float)frameCount/(frameRateConst)), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
}
/* PShape waveC = waveShapePS(origin.x, origin.y, 100, 130, 360, 0);
  waveC.setFill(false);
  waveC.setStroke(255);
  waveC.setStrokeWeight(2);
  main.shape(waveC); */
PShape waveShapePS(float x0, float y0, float radius1, float radius2, int npoints, float seed) {
  float angle = TWO_PI / npoints;
  
  PShape ps = createShape();
  ps.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float xoff = map(cos(a), -1, 1, 0, 3);
    float yoff = map(sin(a), -1, 1, 0, 3);
    float r = map(noise(seed + xoff, yoff, 1.5 * (float)frameCount/(frameRateConst)), 0, 1, radius1, radius2);
    float x = x0 + r * cos(a);
    float y = y0 + r * sin(a);
    ps.vertex(x, y);
  }
  ps.endShape(CLOSE);
  return ps;
}

/* ----------------------- */

// from Fall
PGraphics xCircle(int rad, float lineWidth, color c, boolean filter) {
  int w = rad*2 + 100;
  
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
  
  pg.line(origin.x + rad * cos(QUARTER_PI), origin.y + rad * sin(QUARTER_PI), origin.x + rad * cos(PI + QUARTER_PI), origin.y + rad * sin(PI + QUARTER_PI));
  pg.line(origin.x + rad * cos(HALF_PI + QUARTER_PI), origin.y + rad * sin(HALF_PI + QUARTER_PI), origin.x + rad * cos(-QUARTER_PI), origin.y + rad * sin(-QUARTER_PI));
  
  if (filter) {
    pg.filter(BLUR, 6);
  }
  
  pg.endDraw();
  
  return pg;
}
