// industrialfall

void drawX(float anchorX, float anchorY, float yShift, float xShift) {
  line(anchorX - xShift, anchorY - yShift, anchorX + xShift, anchorY + yShift);
  line(anchorX + xShift, anchorY - yShift, anchorX - xShift, anchorY + yShift);
}

void drawXRect(float anchorX, float anchorY, float yShift, float xShift, float barSize) {
  /*
  float x_shift = cos(radians(45)) * barSize;
  float y_shift = sin(radians(45)) * barSize;
  rect(
  line(anchorX - xShift, anchorY - yShift, anchorX + xShift, anchorY + yShift);
  line(anchorX + xShift, anchorY - yShift, anchorX - xShift, anchorY + yShift); */
  
  float diag = (float) Math.sqrt(Math.pow(xShift, 2) + Math.pow(yShift, 2));
  
  pushMatrix();
  translate(anchorX, anchorY - barSize/2);
  
  // bot r
  rotate(radians(45));
  //rect(0, 0, diag, barSize);
  
  // up r
  rotate(-radians(90));
  // rect(-barSize, 0, diag, barSize);
  
  // up l
  rotate(-radians(90));
  rect(-diag, -barSize, diag*2 - barSize, barSize);
  
  // bot l
  rotate(-radians(90));
  rect(-diag + barSize, -barSize, diag*2 - barSize, barSize);
  
  popMatrix();
}

void girder(float x, float y, float l, float w, float barSize) {
  int numX = ceil(l/w);
  for (int i = 0; i < numX; i++) {
      drawXRect(w*i + x + w/2 + barSize, y, w/2 + barSize/2, w/2 + barSize, barSize);
  }
  
  // top bar
  rect(x, y - w/2 - barSize, l, barSize);
  // bot bar
  rect(x, y + w/2, l, barSize);
}
void girderMove(float x, float y, float l, float w, float barSize, float shift) {
  int numX = ceil(l/w) * 1000;
  for (int i = 0; i < numX; i++) {
      drawXRect(-shift + w*i + x + w/2 + barSize, y, w/2 + barSize/2, w/2 + barSize, barSize);
  }
  
  // top bar
  rect(x, y - w/2 - barSize, l, barSize);
  // bot bar
  rect(x, y + w/2, l, barSize);
}

void mandala(float x, float y) {
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(50));
  scale(0.7, 0.4);
  translate(-origin.x, -origin.y);
    
    pushMatrix();
    translate(x, y);
    rotate(frameCount/(float)(frameRateConst*2));
    // drawMandala(float x, float y, float radius, float radius2, color c)
    // drawMandala2(0, 0, 600, 450, lerpColor(gold, #000000, 0));
    drawMandala(0, 0, 800, 500, lerpColor(gold, #000000, 0.6));
    // drawMandala3(0, 0, 5, 9, gold);
    popMatrix();
    
    stroke(gold);
      
    // dots_star_recursive(float x, float y, float radius1, float radius2, int dot_size, int npoints)
    pushMatrix();
      translate(x, y);
      // rotate(frameCount/(float)24);
      rotate(radians((float)frameCount));
      
      outerKarmaRing(gold);
    popMatrix();
    
    // dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints)
    pushMatrix();
    translate(x, y);
    rotate(frameCount/(float)(frameRateConst * 2));
    // outer 2
    dots_star(0, 0, 600, 550, 1, 40);
    
    rotate(frameCount/(float)(frameRateConst * 2));
    // outer 1
    dots_star(0, 0, 400, 370, 3, 20);
    
    // outer 3 (outermost, big, added for zoom)
    dots_star(0, 0, 1000, 900, 1, 60);
  
    popMatrix();
    
    pushMatrix();
    translate(x, y);
    // rotate(frameCount/(float)24);
    rotate(-radians((float)frameCount));
    
    // dots_star_recursive2(float x, float y, float radius1, float radius2, int dot_size, int npoints, int npoints_limit)
    // in between stars
    dots_star_recursive2(0, 0, 220, 180, ceil(abs(sin(((float)frameCount)/20))*10) + 6, 10, 3);
    dots_star(0, 0, 220, 180, ceil(abs(sin(((float)frameCount)/20))*4), 10);
    
    // outer stars
    // dots_star_recursive2(0, 0, 500, 450, 20, 10, 3);
    
    // center stars
    dots_star_recursive2(0, 0, 120, 70, ceil(abs(sin(((float)frameCount)/20))*30) + 10, 10, 3);
    noFill();
    stroke(gold);
    dots_star_recursive2(0, 0, 120, 70, ceil(abs(sin(((float)frameCount)/20))*30) - 10, 10, 3);
   
    popMatrix();
    
   popMatrix();
}

void mandala2(float x, float y) {
  mandala(x, y);
  
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(50));
  scale(1, 0.6);
  translate(-origin.x, -origin.y);
    // dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints)
    pushMatrix();
    translate(x, y);
    rotate(frameCount/(float)48);
    // outer 2
    dots_star(0, 0, 1400, 1300, 1, 40);
    
    rotate(frameCount/(float)48);
    // outer 1
    dots_star(0, 0, 1200, 1170, 3, 40);
    
    // outer 3 (outermost, big, added for zoom)
    dots_star(0, 0, 1100, 1010, 1, 40);
  
    popMatrix();
  popMatrix();
}
