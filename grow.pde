// grow

void growVase(float x, float y, float pWidth, float pLen, float shiftSize, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    beginShape();
    
    /* FIRST POINT */
    vertex(0, 0);
    
    /* LEFT SIDE LINE */
    float xShift = 0;
    
    int i;
    for (i = 1; i < ceil(lineLen/shiftSize); i++) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {x, y, i});
      
      if (dir == 0) { // left
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize);
    }
    
    /* TOP LINE */
    vertex(xShift, -lineLen);
    vertex(xShift + pWidth, -lineLen);
    
    /* RIGHT SIDE LINE */
    xShift += pWidth;
    
    for (i--; i > 0; i--) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {x, y, i});
      
      if (dir == 0) { // left reversed becomes right (+)
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right reversed becomes left (+)
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize + shiftSize);
    }
    
    endShape(CLOSE);
    popMatrix();
  }
}

void growLadder(float x, float y, float pWidth, float pLen, float spacing, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    /* LEFT SIDE LINE */
    line(0, 0, 0, -lineLen);
    
    /* RUNGS */
    for (int i = 1; i < lineLen; i += spacing) {
      line(0, -i, pWidth, -i);
    }
    
    /* RIGHT SIDE LINE */
    line(pWidth, 0, pWidth, -lineLen);
    
    popMatrix();
  }
}

void columnField(float sep, int distr, int startFrame) { // try sep 2 distr 2
  for (int i = 0; i < width/sep; i += distr) {
    growColumn(i*sep, height, sep, height+sep, 20, 1 + noise(4+i), startFrame);
  }
}
// x, y, pole width, pole length, size of directional shifts, seconds to grow, frame it starts growing on
void growColumn(float x, float y, float pWidth, float pLen, float shiftSize, float growSeconds, int startFrame) {
  if (frameCount > startFrame) {
    
    /* PREP */
    pushMatrix();
    translate(x, y);
    
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = pLen;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * pLen;
    }
    
    beginShape();
    
    /* FIRST POINT */
    vertex(0, 0);
    
    /* LEFT SIDE LINE */
    float xShift = 0;
    
    int i;
    for (i = 1; i < ceil(lineLen/shiftSize); i++) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {noise(x, y), startFrame, i});
      
      if (dir == 0) { // left
        xShift -= shiftSize;
      }
      else if (dir == 2) { // right
        xShift += shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize);
    }
    
    /* TOP LINE */
    vertex(xShift, -lineLen);
    vertex(xShift + pWidth, -lineLen);
    
    /* RIGHT SIDE LINE */
    xShift += pWidth;
    
    for (i--; i > 0; i--) {
      int dir = segNoise(new float[] {0.3, 0.7}, new float[] {noise(x, y), startFrame, i});
      
      if (dir == 0) { // left reversed becomes right (+)
        xShift += shiftSize;
      }
      else if (dir == 2) { // right reversed becomes left (+)
        xShift -= shiftSize;
      }
      
      vertex(0 + xShift, -i*shiftSize + shiftSize);
    }
    
    endShape(CLOSE);
    popMatrix();
  }
}
// eg. given [0.1, 0.4] returns 0 if noise<0.1, 1 if noise<0.4, else 2
int segNoise(float[] f, float[] val) {
  float n = -1;
  if (val.length == 1)
    n = noise(val[0]);
  if (val.length == 2)
    n = noise(val[0], val[1]);
  if (val.length == 3)
    n = noise(val[0], val[1], val[2]);
  
  for (int i = 0; i < f.length; i++) {
    if (n < f[i]) {
      return i;
    }
  }
  return f.length;
}

// like growColumn but with no directional changes in growth
void growPole(float x, float y, float pWidth, float pLen, float growSeconds, int startFrame) {
}

// image(flowerField(height * (3.0/4), 50, 50), 0, 0);
PGraphics flowerField(float stalkHeight, float flowerSize, color stem, color flower, float fieldHorizon, float verSep, float horSep) {
  PGraphics pg = createGraphics(width, height, P3D);
  pg.beginDraw();
  
  for (int row = floor((fieldHorizon-verSep)/verSep); row < (height + verSep)/verSep; row++) {
    for (int col = -1; col < (width + horSep)/horSep; col++) {
      pg.pushMatrix();
      pg.translate(col*horSep + noise(row, col)*horSep*2, row*verSep);
      pg.scale(row/((height + 3*verSep)/verSep));
      pg.rotate((noise(row/2, col/2, 0.3*frameCount/frameRateConst) - 0.5) * PI/4);
      pg.rotate(sin(0.6*frameCount/frameRateConst) * PI/10);
      growFlower(pg, 0, 0, 15, stalkHeight, flowerSize, 0, 0, stem, flower, noise(row, col));
      pg.popMatrix();
    }
  }
  
  pg.endDraw();
  return pg;
}
// ball flower, 3D
void growFlower(PGraphics pg, float x, float y, float w, float h, float flowerSize, int growSeconds, int startFrame, color stem, color flower, float seed) {
  if (frameCount > startFrame) {
    pg.pushMatrix();
    pg.translate(x, y);
    
    boolean growFlower = false;
    
    /* LINE */
    float lineLen;
    if ((frameCount-startFrame)/frameRateConst > growSeconds) {
      lineLen = h;
      growFlower = true;
    }
    else {
      lineLen = (((frameCount-startFrame)/frameRateConst) / growSeconds) * h;
    }
    
    pg.noFill();
    pg.stroke(stem);
    pg.strokeWeight(5);
    pg.beginShape();
    float lastHorShift = -1;
    
    PVector[] points = makeLineVer(lineLen, 4);
    for (int i = 0; i < points.length; i++) {
      if (i % 2 == 0)
        lastHorShift = (noise(seed, -i/2)-0.5) * w;
      else
        lastHorShift = 0;
        
      pg.curveVertex(lastHorShift, points[i].y);
    }
    pg.endShape();
    
    /* FLOWER */
    if (growFlower) {
      PVector center = new PVector(lastHorShift, points[points.length - 1].y);
      pg.noStroke();
      pg.fill(flower);
      
      // could use halos if I wanted more alien flowers
      
      // pg.circle(center.x, center.y, flowerSize); // circle center
      // pg.shape(waveShapePS(0, 0, flowerSize/2, flowerSize/2 + 10, 20, frameCount/frameRateConst), center.x, center.y); // change seed for wavy center
      clusterFlower(pg, center, seed, flowerSize); // cluster of circles
    }
    
    pg.popMatrix();
  }
}
void clusterFlower(PGraphics pg, PVector center, float seed, float flowerSize) {
  float divs = 10;
  for (int i = 0; i < divs; i++) {
    float randrX = (noise(noise(i, center.x), seed, frameCount/frameRateConst) - 0.5) * 25;
    float randrY = (noise(noise(i, center.y), seed, frameCount/frameRateConst) - 0.5) * 25;
    float flowerSizeN = flowerSize * (noise(i, seed, frameCount/frameRateConst)) * 0.5;
    pg.circle(center.x + randrX, center.y + randrY, flowerSizeN);
  }
}
