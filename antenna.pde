int defaultStrokeWeight = 4;
boolean wires = false;

/*
 * Draws an entire antenna starting at the bottom of pg.
 */
void drawAntenna(PGraphics pg, float seed, float poleHeight){
  // smooth(4);
  hint(ENABLE_STROKE_PURE);

  float maxPairShiftX = drawAntennaPole(pg, seed, poleHeight);
  drawAntennaTop(pg, seed, poleHeight, maxPairShiftX);
}

/* Draw the pole for an antenna starting at the bottom of pg
 *
 * Return - half the width of the pole.
 */
float drawAntennaPole(PGraphics pg, float seed, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);

  // center pole 
  pg.strokeWeight(defaultStrokeWeight + noise(seed, 390) * 3);
  pg.line(origin.x, pg.height, origin.x, pg.height-poleHeight);
  pg.strokeWeight(defaultStrokeWeight);
  
  float maxPairShiftX = 0;
  
  int extraPairs = 1 + (int) (noise(seed, 222) * 2);
  for (int i = 0; i < extraPairs; i++) {
    float shiftX = 5 + noise(seed, 3) * 25;
    drawExtraPair(pg, shiftX, poleHeight);
    
    if (shiftX > maxPairShiftX) {
      maxPairShiftX = shiftX;
    }
  }
  
  // decorations to side of pole
  int randTri = 5 + (int) (noise(seed, 4000) * 5);
  for (int i = 0; i < randTri; i++) {
    genSideTri(pg, seed, maxPairShiftX, poleHeight);
  }
  
  int Xs = 1 + (int) (noise(seed, -30) * 4);
  for (int i = 0; i < Xs; i++) {
    genXs(pg, seed, maxPairShiftX, poleHeight);
  }

  // ellipses around poles
  for (int i = 0; i < noise(seed, -2260) * 8 - 5; i++) {
    drawPoleCircles(pg, seed, maxPairShiftX, poleHeight);
  }

  return maxPairShiftX;
}

/* Draw a circle, meant to go around an antenna pole.
 * 
 * pg - PGraphics to draw on
 * seed - noise seed for randomness
 * maxPairShiftX - half the width of the antenna pole
 * poleHeight - height of the antenna pole
 */
void drawPoleCircles(PGraphics pg, float seed, float maxPairShiftX, float poleHeight) {
  float ellipseWidth = maxPairShiftX*2 + noise(seed, 11) * 50;
  float ellipseHeight = 10 + noise(seed, 12) * 10;
  float ellipseY = pg.height - (100 + noise(seed, 13) * (poleHeight - 150));
  pg.noFill();
  pg.ellipse(pg.width / 2, ellipseY, ellipseWidth, ellipseHeight);
}

/* Draw the top of an antenna starting at the bottom of pg
 *
 * pg - PGraphics to draw on
 * seed - noise seed for randomness
 * poleHeight - height of the antenna pole
 * maxPairShiftX - half the width of the antenna pole
 */
void drawAntennaTop(PGraphics pg, float seed, float poleHeight, float maxPairShiftX) {
  PVector origin = new PVector(pg.width/2, pg.height/2);

  // shiftX is half the width of the antenna's top
  float shiftX = min(50 + (noise(seed, -700) * 300), pg.width/2 - 20);
  
  pg.strokeWeight(defaultStrokeWeight + noise(seed, 8) * 3);
  pg.line(origin.x - shiftX, pg.height - poleHeight, origin.x + shiftX, pg.height - poleHeight);
  pg.strokeWeight(defaultStrokeWeight);
  
  float topClass = noise(seed, 9) * 4;
  
  if (topClass > 1) {
    drawPoleTop(pg, seed, shiftX, poleHeight);
  }
  else {
    drawTriTop(pg, seed, shiftX, maxPairShiftX, poleHeight);
  }
}

void drawTriTop(PGraphics pg, float seed, float shiftX, float maxPairShiftX, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);
  float heightY = -1 * (30 + noise(seed, 14) * 30);
  
  pg.noFill();
 
  // BIG triangles
  // left triangle
  pg.triangle(
    origin.x - maxPairShiftX, pg.height - poleHeight, // center
    origin.x - maxPairShiftX - (shiftX/2), pg.height - poleHeight - heightY, // top
    origin.x - shiftX, pg.height - poleHeight); // side
  // right triangle
  pg.triangle(
    origin.x + maxPairShiftX, pg.height - poleHeight,
    origin.x + maxPairShiftX + (shiftX/2), pg.height - poleHeight - heightY,
    origin.x + shiftX, pg.height - poleHeight);
    
  float heightShift1 = 5 + noise(seed, 15) * 10;
  pg.line(origin.x - maxPairShiftX - (shiftX/2), pg.height - poleHeight - heightY, origin.x - maxPairShiftX, pg.height - poleHeight + heightShift1);
  pg.line(origin.x + maxPairShiftX + (shiftX/2), pg.height - poleHeight - heightY, origin.x + maxPairShiftX, pg.height - poleHeight + heightShift1);
  
  int dividers = 3 + (int) (noise(seed, 16) * 3);
  float xSep = shiftX/dividers;
  for (int i = 1; i < dividers; i++) {
    pg.line(origin.x - maxPairShiftX - (shiftX/2), pg.height - poleHeight - heightY, origin.x - maxPairShiftX - xSep * i, pg.height - poleHeight); // left
    pg.line(origin.x + maxPairShiftX + (shiftX/2), pg.height - poleHeight - heightY, origin.x + maxPairShiftX + xSep * i, pg.height - poleHeight); // right
  }
  
  int dividers2 = (int) (noise(seed, 17) * 7) - 4;
  float xSep2 = shiftX/dividers2;
  for (int i = 1; i < dividers2; i++) {
    pg.line(origin.x - maxPairShiftX - (shiftX/2), pg.height - poleHeight, origin.x - maxPairShiftX - xSep2 * i, pg.height - poleHeight - heightY); // left
    pg.line(origin.x + maxPairShiftX + (shiftX/2), pg.height - poleHeight, origin.x + maxPairShiftX + xSep2 * i, pg.height - poleHeight - heightY); // right
  }
  
  int otherSideTri = 1 + (int) (noise(seed, 18) * 5);
  float triWidth = 30 + noise(seed, 21) * 20;
  for (int i = 0; i < otherSideTri; i++) {
    float triHeight = ((noise(seed, 20) * 4) > 1) ? ((10 + (noise(seed, 21) * 15)) * (heightY < 0 ? 1 : -1)) : 0;
    pg.triangle(
      origin.x - shiftX + triWidth*i, pg.height - poleHeight,
      origin.x - shiftX + triWidth*i + (triWidth/2), pg.height - poleHeight - triHeight,
      origin.x - shiftX + triWidth*i + triWidth, pg.height - poleHeight
    );
    pg.triangle(
      origin.x + shiftX - triWidth*i, pg.height - poleHeight,
      origin.x + shiftX - triWidth*i - (triWidth/2), pg.height - poleHeight - triHeight,
      origin.x + shiftX - triWidth*i - triWidth, pg.height - poleHeight
    );
  }
}

float drawBoxTop(PGraphics pg, float seed, float shiftX, float poleHeight) {
  float sideX = 10 + noise(seed, 22) * (shiftX - 100);
  float heightY = noise(seed, 23) * 35;
  PVector origin = new PVector(pg.width/2, pg.height/2);

  pg.noFill();
  
  // drawXSeries
  int xNumber = (int) (noise(seed, 24) * 4 + 4);
  float xWidth = sideX / (xNumber);
  float yHeight = heightY/2;
  
  if (noise(seed, 25) * 4 > 1) {
    for (int i = 0; i < xNumber; i++) {
      drawX(pg, origin.x - sideX + xWidth * (i * 2 + 1), pg.height - poleHeight - yHeight, yHeight, xWidth);
    }
  }
  
  if (noise(seed, 26) * 4 > 2) {
    for (int i = 0; i < xNumber; i++) {
      pg.line(origin.x - sideX + xWidth * (i * 2 + 2), pg.height - poleHeight, origin.x - sideX + xWidth * (i * 2 + 2), pg.height - poleHeight - heightY);
    }
  }
  pg.rect(origin.x - sideX, pg.height - poleHeight - heightY, sideX * 2, heightY);
  
  if (heightY > 20 || noise(seed, 27) * 4 > 2) {
    heightY /= 2;
    float sideX2 = noise(seed, 28) * 40 + 10;
    
    pg.rect(origin.x - sideX - sideX2, pg.height - poleHeight - heightY, sideX2, heightY);
    pg.rect(origin.x + sideX, pg.height - poleHeight - heightY, sideX2, heightY);
    
    if (heightY > 10) {
      sideX += sideX2;
    }
    
  }
  
  return sideX;
}

void drawPoleTop(PGraphics pg, float seed, float shiftX, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);

  // flat pole top
  float sideX = 50;
  if (noise(seed, 279) * 4 > 1) {
    sideX = drawBoxTop(pg, seed, shiftX, poleHeight) + 10;
  }
  
  drawTopVerticals(pg, seed, sideX, shiftX, poleHeight);
  
  if (noise(seed, 30) * 5 > 4) {
    float diam = noise(seed, 31) * (9 - (defaultStrokeWeight + 1)) + defaultStrokeWeight + 1;

    pg.circle(origin.x - shiftX - diam/2, pg.height - poleHeight, diam);
    pg.circle(origin.x + shiftX + diam/2, pg.height - poleHeight, diam);
  }
}

void drawTopVerticals(PGraphics pg, float seed, float sideX, float shiftX, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);
  float wireX = pg.width + noise(seed, 32) * pg.width;
  float wireY = - (noise(seed, 41) * pg.height);
  
  for (int i = 0; i < 1 + noise(seed, 42) * 2; i++) {
    float x2 = noise(seed, 36) * (shiftX - sideX) + sideX;
    float heightY = 5 + noise(seed, 37) * 95;
  
    pg.line(origin.x - x2, pg.height - poleHeight - heightY, origin.x - x2, pg.height - poleHeight + heightY);
    pg.line(origin.x + x2, pg.height - poleHeight - heightY, origin.x + x2, pg.height - poleHeight + heightY);
    
    if (wires) {
      pg.strokeWeight(defaultStrokeWeight/3);
      pg.line(origin.x - x2, pg.height - poleHeight - heightY, origin.x - x2 - wireX, wireY);
      pg.line(origin.x + x2, pg.height - poleHeight - heightY, origin.x + x2 + wireX, wireY);
      pg.strokeWeight(defaultStrokeWeight);
    }
    
    float diam = 1 + (noise(seed, 38) * 2) * 2;
    
    // draw pg.circles on top
    if (noise(seed, 39) * 10 < 7) {
      pg.fill(#000000);
      pg.circle(origin.x - x2, pg.height - poleHeight - heightY - diam, diam);
      pg.circle(origin.x + x2, pg.height - poleHeight - heightY - diam, diam);
      
      // draw pg.circles on bottom
      if (noise(seed, 40) * 10 < 4) {
        pg.circle(origin.x - x2, pg.height - poleHeight + heightY + diam, diam);
        pg.circle(origin.x + x2, pg.height - poleHeight + heightY + diam, diam);
      }
    }
    
    if (noise(seed, 41) * 10 < 7) {
      float widthX2 = noise(seed, 42) * 5 + 2;
      float distY = noise(seed, 43) * (heightY - 10) + 5;
      pg.line(origin.x - x2 - widthX2, pg.height - poleHeight - heightY + distY, origin.x - x2 + widthX2, pg.height - poleHeight - heightY + distY);
      pg.line(origin.x + x2 - widthX2, pg.height - poleHeight - heightY + distY, origin.x + x2 + widthX2, pg.height - poleHeight - heightY + distY);
    }

  }
}

void drawExtraPair(PGraphics pg, float shiftX, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);
  pg.line(origin.x - shiftX, pg.height, origin.x - shiftX, pg.height-poleHeight);
  pg.line(origin.x + shiftX, pg.height, origin.x + shiftX, pg.height-poleHeight);
}

void genSideTri(PGraphics pg, float seed, float maxPairShiftX, float poleHeight) {
  float xShift;
  if (noise(seed, 44) * 6 > 5) {
    xShift = 5 + noise(seed, 46) * 20;
  }
  else {
    xShift = maxPairShiftX;
  }
  
  float yShift = 20 + noise(seed, 401) * 80;
  
  float anchorY = pg.height - 100 - noise(seed, 502) * (poleHeight - 200);
  
  triLines(pg, anchorY, yShift, xShift);
  triLines(pg, anchorY, yShift, -xShift);
}

void triLines(PGraphics pg, float anchorY, float yShift, float xShift) {
  PVector origin = new PVector(pg.width/2, pg.height/2);
  pg.line(origin.x, anchorY + yShift, origin.x + xShift, anchorY);
  pg.line(origin.x + xShift, anchorY, origin.x, anchorY - yShift);
}

void genXs(PGraphics pg, float seed, float maxPairShiftX, float poleHeight) {
  PVector origin = new PVector(pg.width/2, pg.height/2);

  // float xShift = 5 + random(maxPairShiftX - 5);
  float xShift = maxPairShiftX;
  float yShift = 5 + noise(seed, 504) * 15;
  float anchorY = pg.height - 20 - noise(seed, 1001) * (poleHeight - 40);
  
  drawX(pg, origin.x, anchorY, yShift, xShift);
}

void drawX(PGraphics pg, float anchorX, float anchorY, float yShift, float xShift) {
  pg.line(anchorX - xShift, anchorY - yShift, anchorX + xShift, anchorY + yShift);
  pg.line(anchorX + xShift, anchorY - yShift, anchorX - xShift, anchorY + yShift);
}