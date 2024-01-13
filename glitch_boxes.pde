// glitch_boxes
  
  // glitchCloudCube(origin.x, origin.y, 0, 100, 5, 20, 0, 1);
  // glitchCloudSquare(origin.x, origin.y, 0, 150, 5, 10, 6, 1);
  // glitchCloudImage(karma[(frameCount/(int)frameRateConst % 10)], gold, origin.x, origin.y, 0, 150, 10, 30, 6, 1);
  // glitchCloudArray(karma, gold, origin.x, origin.y, 0, 150, 10, 30, 6, 1);
  // glitchCloudSquare2(gold, origin.x, origin.y, 0, 200, 10, 20, 6, 1);

// 3D, cloud of glitchy squares/cubes around a center point
void glitchCloudCube(float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudCube(g, x, y, z, randr, num, size, seed, speed);
}
void glitchCloudCube(PGraphics pg, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
   for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(x + y + i + frameCount*speed + seed)-0.5;
    float zn = noise(x + y + z, i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;

    float black = 0;
    if (noise((seed/10) * i) > 0.5) {
      black = 1;
    }
    pg.fill(lerpColor(#000000, #ffffff, black));
    pg.strokeWeight(2);
    pg.stroke(lerpColor(#fceabf, #db8e0a, constrain((xn + yn + zn)/3 * 3 + 0.5, 0, 1)));

    placeBox(pg, x + xx, y + yy, z + zz,
      rotX, rotY, rotZ, size);
  }
}

void glitchCloudSquare(float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudSquare(g, x, y, z, randr, num, size, seed, speed);
}
void glitchCloudSquare(PGraphics pg, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(x + y + i + frameCount*speed + seed)-0.5;
    float zn = noise(x + y + z, i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeSquare(pg, x + xx, y + yy, 0, 0, size);
  }
}


void glitchCloudSquare2(color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudSquare2(g, c, x, y, z, randr, num, size, seed, speed);
}
void glitchCloudSquare2(PGraphics pg, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(x + y + i + frameCount*speed + seed)-0.5;
    float zn = noise(x + y + z, i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeSquare2(pg, x + xx, y + yy, z + zz, 0, size, lerpColor(c, 0, xn + random(0.5)), lerpColor(c, 0, yn + random(0.5)), lerpColor(c, 0, zn + random(0.5)));
  }
}

void glitchCloudImage(PGraphics pg, PGraphics image, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudImage(pg, image, c, x, y, z, randr, num, size, size, seed, speed);
}
void glitchCloudImage(PGraphics image, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudImage(g, image, c, x, y, z, randr, num, size, size, seed, speed);
}
void glitchCloudImage(PGraphics pg, PGraphics image, color c, float x, float y, float z, float randr, float num, float sizeX, float sizeY, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    float zn = noise(z + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    
    float rotX = xn*360;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeImage(pg, image, x + xx, y + yy, z + zz, 0, sizeX, sizeY, c);
  }
}

void glitchCloudImage2D(PGraphics pg, PGraphics image, color c, float x, float y, float randr, float num, float sizeX, float sizeY, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(y + i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    
    float rotX = xn*360;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */
    
    placeImage2D(pg, image, x + xx, y + yy, 0, sizeX, sizeY, c);
  }
}

void glitchCloudArray(PGraphics pg, PImage[] images, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + frameCount*speed + seed)-0.5;
    float yn = noise(x + y + i + frameCount*speed + seed)-0.5;
    float zn = noise(x + y + z, i + frameCount*speed + seed)-0.5;
    // position nums
    float xx = xn*randr;
    float yy = yn*randr;
    float zz = zn*randr;
    
    float rotX = xn*360;
    /*
    // rotation nums
    float rotX = xn*360;
    float rotY = yn*360;
    float rotZ = zn*360;
    */

    pg.imageMode(CENTER);
    pg.noStroke();
    pg.fill(#000000);
    pg.circle(origin.x+xx, origin.y+yy, size);

    // showFrame(PImage[] array, float deg, float x, float y, float h, float w, int shift)
    // pg.tint(lerpColor(#fceabf, #db8e0a, constrain((xn + yn + zn)/3 * 3 + 0.5, 0, 1)));
    showFrame(pg, images, rotX, xx, yy, size, size, i);
  }
}

void glitchCloudArray(PImage[] images, color c, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  g.tint(c, 255);
  glitchCloudArray(g, images, x, y, z, randr, num, size, seed, speed);
  g.tint(255, 255);
}

void placeImage2D(PGraphics pg, PGraphics image, float x, float y, float rot, float sizeX, float sizeY, color c) {
  int oldMode = pg.imageMode;
  pg.imageMode(CORNER);
  pg.pushMatrix();
  pg.translate(x, y);
  pg.rotate(radians(rot));
  pg.tint(c, 255);
  pg.image(image, 0, 0, sizeX, sizeY);
  pg.tint(255, 255);
  pg.popMatrix();
  pg.imageMode(oldMode);
}

void placeImage(PGraphics pg, PGraphics image, float x, float y, float z, float rot, float size, color c) {
  placeImage(pg, image, x, y, z, rot, size, size, c);
}
void placeImage(PGraphics pg, PGraphics image, float x, float y, float z, float rot, float sizeX, float sizeY, color c) {
  int oldMode = pg.imageMode;
  pg.imageMode(CORNER);
  pg.pushMatrix();
  pg.translate(x, y, z);
  pg.rotate(radians(rot));
  pg.tint(c, 255);
  pg.image(image, 0, 0, sizeX, sizeY);
  pg.tint(255, 255);
  pg.popMatrix();
  pg.imageMode(oldMode);
}

void placeSquare(PGraphics pg, float x, float y, float z, float rot, float size) {
  pg.pushMatrix();
  pg.translate(x, y, z);
  pg.rotate(radians(rot));
  pg.square(0, 0, size);
  pg.popMatrix();
}

void placeSquare2(PGraphics pg, float x, float y, float z, float rot, float size, color fil1, color fil2, color line) {
  pg.pushMatrix();
  pg.translate(x, y, z);
  pg.rotate(radians(rot));
  
  pg.stroke(line);
  pg.fill(fil1);
  pg.square(0, 0, size);
  
  pg.noStroke();
  pg.fill(fil2);
  pg.square(size/4, size/4, size/2);
  pg.popMatrix();
}

void placeBox(PGraphics pg, float x, float y, float z, float rotX, float rotY, float rotZ, float size) {
  pg.pushMatrix();
  pg.translate(x, y, z);
  pg.rotateX(radians(rotX));
  pg.rotateY(radians(rotY));
  pg.rotateZ(radians(rotZ));
  pg.box(size);
  pg.popMatrix();
}

/* ---------------- */

void glitchCloudSquare3(PImage texture, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    for (int i = 0; i < num; i++) {
      // random(noise) nums
      float xn = noise(x + i + frameCount*speed + seed)-0.5;
      float yn = noise(y + i + frameCount*speed + seed)-0.5;
      float zn = noise(z + i + frameCount*speed + seed)-0.5;
      // position nums
      float xx = xn*randr;
      float yy = yn*randr;
      float zz = zn*randr;
      float rotX = xn*360;
      /*
      // rotation nums
      float rotX = xn*360;
      float rotY = yn*360;
      float rotZ = zn*360;
      */
      
      pg.pushMatrix();
      pg.translate(x + xx, y + yy);
      // pg.rotate(radians(rotX));
      pg.fill(255);
      pg.square(0, 0, size);
      pg.popMatrix();
  }
  pg.endDraw();
  
  texture.mask(pg);
  image(texture, 0, 0);
}

void glitchCloudRect(PImage texture, float x, float y, float randr, float num, float rectw, float recth, float seed, float speed) {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    for (int i = 0; i < num; i++) {
      // random(noise) nums
      float xn = noise(x + i + frameCount*speed + seed)-0.5;
      float yn = noise(y + i + frameCount*speed + seed)-0.5;
      // position nums
      float xx = xn*randr;
      float yy = yn*randr;
      float rot = xn*360;
      
      pg.pushMatrix();
      pg.translate(x + xx, y + yy);
      // pg.rotate(radians(rotX));
      pg.fill(255);
      pg.rect(0, 0, rectw * noise(i + frameCount*speed + seed), recth * noise(i + frameCount*speed + seed));
      pg.popMatrix();
  }
  pg.endDraw();
  
  texture.mask(pg);
  image(texture, 0, 0);
}
