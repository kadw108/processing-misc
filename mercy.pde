/* 

ideas 

cat: default animation (-> crack + flies + going upwards), lotus face, xcircle face, glitch face, glitch karma face

can actually ignore

ignore background for now
background: sky, flies going upward in bg, lotus bg, batfly halo?, multiple transmission towers, karma flower halo (+ void tendril halo + lotus halo??), 
*/

import java.util.Arrays;

PVector origin;
color gold = #fcc205;

color darkgold_c = #d8a93c;
color gold_c = #fcc205;

int w;

// animaion runs at / is saved at 60 frames per second
float frameRateConst = 12;

PImage xCircle;
PImage[] karma;

PImage bg;

PenroseLSystem ds;
ParticleSystem ps;

PGraphics main;

KarmaChar[][] karmaArray;

PImage plan;
PImage[] mercy_bg;
PImage[] xcircle_small;
PImage[] xcircle_big;
PImage[] mercy_kflower;

PImage[] batfly1_line;
PImage[] batfly1_color;
PImage batfly1_eyes;

PImage[] batfly2_line;
PImage[] batfly2_color;
PImage batfly2_eyes;

PImage[] liz_color1;
PImage[] liz_color2;
PImage[] liz_eye;
PImage[] liz_line;

PImage[] squidcada_color1;
PImage[] squidcada_color2;
PImage[] squidcada_eye;
PImage[] squidcada_line;

PImage[] tendrils_color;
PImage[] tendrils_line;

PImage[] cat_color;
PImage[] cat_line;
PImage[] cat_line_change;

color darkline_c;
color pole_c;
color wires_c;
color vines_c;
color cat_c;
color liz_c;
color squid_color1_c;
color squid_color2_c;
color squid_eye_c;
color batfly_c;
color batfly_eye_c;

PVector voidPos;
PVector catPos;
PVector xCircleSmallPos;
PVector batflyPos;
PVector lizPos1;
PVector xCircleBigPos;
PVector squidcadaPos;

void setup(){
  // size(3221, 3064);
  // size(400, 400, P3D);
  size(1920, 1080);
  origin = new PVector(width/2, height/2);

  xCircle = loadImage("/home/account/Documents/prog/processing/rw/0rw_data/xCircle3.png");
  bg = loadImage("/home/account/Documents/prog/processing/rw/0rw_data/sky2.jpg");
  bg.resize(3221, 3064);
  
  karma = loadKarma();

  /* --- */

  plan = loadImage("plan.png");

  // PImage[] loadRange(String name, int start, int end, String extension, int leng, int skip)
  mercy_bg = loadRange("mercy1bg/mercy1-", 1, 5, ".png");
  xcircle_small = loadRange("xcircle-small/xcircle-small-", 1, 5, ".png");
  xcircle_big = loadRange("xcircle_big", 1, 3, ".png");
  mercy_kflower = loadRange("mercykflower/mercy-kflower-", 1, 19, ".png");

  batfly1_line = loadRange("batfly1/batfly1-", 2, 6, ".png", 2);
  batfly1_color = loadRange("batfly1/batfly1-", 1, 5, ".png", 2);
  batfly1_eyes = loadImage("batfly1/batfly1-8.png"); // 8 is small eyes, 7 is big

  batfly2_line = loadRange("batfly2/batfly2-", 2, 6, ".png", 2);
  batfly2_color = loadRange("batfly2/batfly2-", 1, 5, ".png", 2);
  batfly2_eyes = loadImage("batfly2/batfly2-7.png");

  liz_color1 = loadRange("liz/mercy1-lizard-", 1, 17, ".png", 4);
  liz_color2 = loadRange("liz/mercy1-lizard-", 2, 18, ".png", 4);
  liz_eye = loadRange("liz/mercy1-lizard-", 3, 19, ".png", 4);
  liz_line = loadRange("liz/mercy1-lizard-", 4, 20, ".png", 4);

  squidcada_color1 = loadRange("squidcada/squidcada-", 1, 13, ".png", 4);
  squidcada_color2 = loadRange("squidcada/squidcada-", 2, 14, ".png", 4);
  squidcada_eye = loadRange("squidcada/squidcada-", 3, 15, ".png", 4);
  squidcada_line = loadRange("squidcada/squidcada-", 4, 16, ".png", 4);

  tendrils_color = loadRange("voidtendrils/mercy1-voidtendrils-", 1, 9, ".png", 2);
  tendrils_line = loadRange("voidtendrils/mercy1-voidtendrils-", 2, 10, ".png", 2);

  cat_color = loadRange("mercycat/mercy1-cat-", 1, 9, ".png", 2);
  cat_line = loadRange("mercycat/mercy1-cat-", 2, 10, ".png", 2);
  cat_line_change = loadRange("mercycat/mercy1-cat-", 11, 20, ".png");

  /* --- colors --- */

  darkline_c = #ffffff;

  pole_c = #6a4444;
  // wires_c = #523025;
  wires_c = #ffffff;
  // vines_c = #955439;
  vines_c = #ffffff;

  cat_c = #dedcc7;

  // liz_c = #d22960;
  liz_c = #ffc740;

  squid_color1_c = cat_c;
  squid_color2_c = #7292a8;
  squid_eye_c = #344570;

  batfly_c = pole_c;
  batfly_eye_c = #ffffff;

  /* --- positions --- */

  voidPos = new PVector(origin.x, origin.y - 550);
  catPos = new PVector(origin.x - 20, origin.y + 40);
  xCircleSmallPos = new PVector(catPos.x + 40, catPos.y - 70);
  batflyPos = new PVector(xCircleSmallPos.x - 20, xCircleSmallPos.y);

  lizPos1 = new PVector(origin.x + 520, origin.y + 340); // liz right
  xCircleBigPos = new PVector(origin.x, origin.y - 350);
  squidcadaPos = new PVector(origin.x, origin.y - 350);

  /* --- */

  frameRate(frameRateConst);
  
  ds = new PenroseLSystem();
  ds.simulate(5);
  
  ps = new ParticleSystemF(new PVector(origin.x, origin.y));
  
  imageMode(CENTER);
}

/* ------------------------------- DRAW | DRAW | DRAW -------------------------------- */

void draw(){
  int fC_8 = (int) ((8 * frameCount) / frameRateConst); // increments 8 times per second
  int fC_12 = (int) ((12 * frameCount) / frameRateConst); // increments 12 times per second
  int fC_24 = (int) ((24 * frameCount) / frameRateConst); // increments 24 times per second
  float seconds = frameCount/frameRateConst;

  background(0);

  // drawBatfly(fC_12);
  // drawAll(fC_12);

  // drawKarmaCluster(fC_12);
  // drawCubeCluster(fC_12);

  drawKarmaSpiral(fC_12, seconds);
  // drawKFlowerHalo(fC_12);
  // drawNestedFlower(fC_24 * 0.5);

  print("seconds " + seconds + " framecount " + frameCount + " fC_12 " + fC_12, "\n");
}

void glitchCloudBatfly(PGraphics pg, PGraphics image, color c, float x, float y, float randr, float num, float sizeX, float sizeY, float seed, float speed, float fC) {
  for (int i = 0; i < num; i++) {
    // random(noise) nums
    float xn = noise(x + i + fC*speed + seed)-0.5;
    float yn = noise(y + i + fC*speed + seed)-0.5;
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

    placeImage2D(pg, image, x + xx, y + yy, rotX, sizeX, sizeY, c);
  }
}

PImage getPatternMask(int fC) {
  String smokePath = "/home/account/containers/resolve/mounts/resolve-home/psychedelic_sky_islands/assets/pubdomain/patterns/yellowsmoke";
  String frameNum = String.valueOf((fC % 1209) + 1);
  int frameNumLeng = frameNum.length();
  for (int i = 0; i < 5 - frameNumLeng; i++) {
    frameNum = "0" + frameNum;
  }
  PImage smokeMask = loadImage(smokePath + "/" + frameNum + ".jpg");
  return smokeMask;
}

void drawAll(int fC_12) {
  color old_darkline_c = #1e0505;

  // background(bg);

  main = createGraphics(width, height);
  main.beginDraw();
  main.imageMode(CENTER);

  /* --- bg --- */

  // pole
  main.tint(pole_c);
  main.image(mercy_bg[0], origin.x, origin.y);

  // pole outline
  main.tint(darkline_c);
  main.image(mercy_bg[1], origin.x, origin.y);

  // wires 1
  main.tint(wires_c, 160);
  main.image(mercy_bg[2], origin.x, origin.y);
  // wires 2
  main.image(mercy_bg[3], origin.x, origin.y);

  // vines
  main.tint(vines_c, 195);
  main.image(mercy_bg[4], origin.x, origin.y);

  /* --- voidtendrils --- */

  /*
  main.tint(gold_c, 70);
  main.image(getFrameBounce(tendrils_color, 0, fC_12), voidPos.x, voidPos.y);
  main.tint(darkgold_c, 190);
  main.image(getFrameBounce(tendrils_line, 0, fC_12), voidPos.x, voidPos.y);
  */

  /* --- xCircle small */
  /*
  main.tint(gold_c);
  main.image(getFrameBounce(xcircle_small, 0, fC_12), xCircleSmallPos.x, xCircleSmallPos.y);
  */

  /* --- cat --- */

  main.noStroke();
  // main.fill(darkline_c);
  main.fill(old_darkline_c);
  main.circle(catPos.x + 40, catPos.y - 50, 80);

  main.tint(cat_c);
  main.image(getFrameBounce(cat_color, 0, fC_12), catPos.x, catPos.y);

  main.tint(darkline_c);
  main.image(getFrameBounce(cat_line, 0, fC_12), catPos.x, catPos.y);

  /* --- cat batflies --- */
  // drawBatflyCluster(fC_12);

  /* --- liz --- */

  // liz right
  main.tint(darkline_c);
  main.image(getFrameBounce(liz_color1, 0, fC_12), lizPos1.x, lizPos1.y);
  main.tint(liz_c);
  main.image(getFrameBounce(liz_color2, 0, fC_12), lizPos1.x, lizPos1.y);
  main.tint(old_darkline_c);
  main.image(getFrameBounce(liz_eye, 0, fC_12), lizPos1.x, lizPos1.y);
  main.tint(darkline_c);
  main.image(getFrameBounce(liz_line, 0, fC_12), lizPos1.x, lizPos1.y);

  // liz left
  main.pushMatrix();
  main.scale(-1, 1);
  PVector newLizPos = new PVector(lizPos1.x, lizPos1.y);
  newLizPos.x = - (width - lizPos1.x);
  main.tint(darkline_c);
  main.image(getFrameBounce(liz_color1, 0, fC_12), newLizPos.x, lizPos1.y);
  main.tint(liz_c);
  main.image(getFrameBounce(liz_color2, 0, fC_12), newLizPos.x, lizPos1.y);
  main.tint(old_darkline_c);
  main.image(getFrameBounce(liz_eye, 0, fC_12), newLizPos.x, lizPos1.y);
  main.tint(darkline_c);
  main.image(getFrameBounce(liz_line, 0, fC_12), newLizPos.x, lizPos1.y);
  main.popMatrix();

  /* --- xCircle big --- */
  /*
  main.tint(gold_c);
  main.image(getFrameBounce(xcircle_big, 0, fC_12), xCircleBigPos.x, xCircleBigPos.y);
  */

  /* --- squidcada --- */
  /*
  PVector smallSize = new PVector(squidcada_color1[0].width, squidcada_color1[0].height).mult(0.9);

  main.tint(squid_color1_c);
  main.image(getFrameBounce(squidcada_color1, 0, fC_12), squidcadaPos.x, squidcadaPos.y, smallSize.x, smallSize.y);
  main.tint(squid_color2_c);
  main.image(getFrameBounce(squidcada_color2, 0, fC_12), squidcadaPos.x, squidcadaPos.y, smallSize.x, smallSize.y);
  main.tint(squid_eye_c);
  main.image(getFrameBounce(squidcada_eye, 0, fC_12), squidcadaPos.x, squidcadaPos.y, smallSize.x, smallSize.y);
  main.tint(darkline_c);
  main.image(getFrameBounce(squidcada_line, 0, fC_12), squidcadaPos.x, squidcadaPos.y, smallSize.x, smallSize.y);
  */

  main.endDraw();
  // image(main, origin.x, origin.y);

  if (fC_12 < 80) {
    main.save("save/"+String.format("%04d", frameCount)+".png");
  }
}

void drawBatfly(int fC) {
  int i = 0;

  if (true) {
    batfly_c = #ffffff;
    batfly_eye_c = #ffffff;
    darkline_c = #ffffff;
  }

  PGraphics batfly = createGraphics(batfly1_eyes.width, batfly1_eyes.height);
  batfly.imageMode(CORNER);
  batfly.beginDraw();
  batfly.tint(batfly_c);
  PImage batfly_color_frame = getFrameBounce(batfly1_color, i, fC);
  batfly.image(batfly_color_frame, 0, 0);

  // mask for batfly color
  PGraphics maskG = createGraphics(batfly_color_frame.width, batfly_color_frame.height);
  maskG.imageMode(CORNER);
  maskG.beginDraw();
  maskG.image(batfly_color_frame, 0, 0);
  maskG.endDraw();
  PImage smokeMask = getPatternMask(fC);
  smokeMask.resize(maskG.width, maskG.height);
  smokeMask.mask(maskG);
  batfly.tint(#ffffff, 250);
  // batfly.image(smokeMask, 0, 0);

  batfly.tint(darkline_c);
  batfly.image(getFrameBounce(batfly1_line, i, fC), 0, 0);
  batfly.tint(batfly_eye_c);
  batfly.image(batfly1_eyes, 0, 0);
  batfly.endDraw();

  if (fC < 10) {
    batfly.save("save/"+String.format("%04d", frameCount)+".png");
  }
}

void drawBatflyCluster(int fC_12) {
  int change_frame = 24;
  if (fC_12 >= change_frame) {
    PImage p = getFrameBounceLast(cat_line_change, 5, fC_12 - change_frame);
    main.image(p, catPos.x, catPos.y);
  }

  int swarm_frame = change_frame + 3;
  // batfly placer - draws 7 iterations of different batflies, places a few of each
  // for (int i = 0; i < 7; i++) {
  for (int i = 0; i < 1 + ceil((fC_12 - swarm_frame) * 1); i++) {

    PGraphics batfly = createGraphics(batfly1_eyes.width, batfly1_eyes.height);
    batfly.imageMode(CORNER);
    batfly.beginDraw();
    batfly.tint(batfly_c);
    PImage batfly_color_frame = getFrameBounce(batfly1_color, i, fC_12);
    batfly.image(batfly_color_frame, 0, 0);

    // mask for batfly color
    PGraphics maskG = createGraphics(batfly_color_frame.width, batfly_color_frame.height);
    maskG.imageMode(CORNER);
    maskG.beginDraw();
    maskG.image(batfly_color_frame, 0, 0);
    maskG.endDraw();
    PImage smokeMask = getPatternMask(fC_12);
    smokeMask.resize(maskG.width, maskG.height);
    smokeMask.mask(maskG);
    batfly.tint(#ffffff, 200);
    batfly.image(smokeMask, 0, 0);

    batfly.tint(darkline_c);
    batfly.image(getFrameBounce(batfly1_line, i, fC_12), 0, 0);
    batfly.tint(batfly_eye_c);
    batfly.image(batfly1_eyes, 0, 0);
    batfly.endDraw();

    // --- batflies swarm around head --- 

    float seed = 6*i;
    float speed = 0.09;

    PVector size = new PVector(batfly1_eyes.width, batfly1_eyes.height);
    float min_size = 0.4;
    float max_size = 0.9;
    size = size.mult(min_size + (noise(fC_12 * speed + seed) * (max_size - min_size)));

    glitchCloudBatfly(main, batfly, gold, batflyPos.x, batflyPos.y, 160, 2, size.x, size.y, seed, speed, fC_12);

    /* --- cat batflies going up --- */
    /*
      Concept
      loop:
        single batfly
        start from slug head
        dest point at top of screen, random x
        random horizontal movement every frame plus constant towards dest point

      ... f that generate a batfly gif and animate it with resolve, a million times easier
    */
  }
}

void drawKarmaCluster(int fC_12) {
  main = createGraphics(width, height);
  main.beginDraw();
  main.imageMode(CENTER);

  // void glitchCloudArray(PGraphics pg, PImage[] images, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  // there is a line in actual glitchCloudArray code you must comment in to get the colors right
  glitchCloudArray(main, karma, origin.x, origin.y, 0, 400, 100, 30, fC_12, 1);

  main.endDraw();
  image(main, origin.x, origin.y);

  if (fC_12 < 80) {
    main.save("save/"+String.format("%04d", frameCount)+".png");
  }
}


// glitchCloudCube(origin.x, origin.y, 0, 100, 5, 20, 0, 1);

void drawCubeCluster(int fC_12) {
  main = createGraphics(width, height, P3D);
  main.beginDraw();
  main.imageMode(CENTER);

  // void glitchCloudArray(PGraphics pg, PImage[] images, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  // glitchCloudArray(main, karma, origin.x, origin.y, 0, 400, 100, 30, fC_12, 1);

  // main.stroke(#ffc740);
  // main.fill(#000000);

  // void glitchCloudCube(PGraphics pg, float x, float y, float z, float randr, float num, float size, float seed, float speed) {
  glitchCloudCube(main, origin.x, origin.y, 100, 200, 30, 30, fC_12, 1);

  main.endDraw();
  image(main, origin.x, origin.y);

  if (fC_12 < 80) {
    main.save("save/"+String.format("%04d", frameCount)+".png");
  }
}

void drawKarmaSpiral(int fC_12, float seconds) {
  // Adopted from saved file in ARCHIVE (misc2)

  main = createGraphics(width, height);
  main.beginDraw();

  main.imageMode(CENTER);
  main.translate(origin.x, origin.y);
  main.rotate(radians(seconds * 5));

  // void custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust)
  // void dots_star(float x, float y, float radius1, float radius2, int dot_size, int npoints) {
  main.stroke(#ffc740);
  main.fill(0);
  dots_star(main, 0, 0, 570, 580, 7, 50);
  dots_star(main, 0, 0, 590, 610, 3, 100);
  custStar(main, 0, 0, 620, 650, 30, TRIANGLE_STRIP);

  main.stroke(lerpColor(#ffc740, #bf5d01, 0.2));
  custStar(main, 0, 0, 740, 680, 30, TRIANGLE_STRIP);
  main.stroke(lerpColor(#ffc740, #bf5d01, 0.55));
  custStar(main, 0, 0, 820, 770, 30, TRIANGLE_STRIP);
  main.stroke(lerpColor(#ffc740, #bf5d01, 0.85));
  custStar(main, 0, 0, 870, 920, 60, TRIANGLE_STRIP);
  main.stroke(lerpColor(#ffc740, #bf5d01, 1));
  custStar(main, 0, 0, 950, 1000, 120, TRIANGLE_STRIP);
  main.stroke(lerpColor(#ffc740, #bf5d01, 1));
  custStar(main, 0, 0, 1050, 1100, 120, TRIANGLE_STRIP);

  // void showKarma(float x, float y, float radius1, float radius2, float iconSize, float deg, color c, PGraphics main) {
  for (int i = 0; i < 15; i++) {
    main.push();
    main.rotate(i * 24);
    showKarma(0, 0,
      i * 35 + 60, i * 35 + 60,
      45 - i * 1.9,
      fC_12 * 3.6 + i * 36,
      lerpColor(#ffffff, #ffc740, i/(float)9),
      main, 
      true);

    main.pop();
  }

  main.noStroke();
  main.fill(#000000);
  main.circle(0, 0, 50);
  main.image(karma[((int) (fC_12)) % 10], 0, 0, 50, 50);

  main.endDraw();

  image(main, origin.x, origin.y);

  if (fC_12 < 100) {
    save("save/"+String.format("%04d", frameCount)+".png");
  }
}

void drawKFlowerHalo(int fC_12) {
  // void ellipseImage(PGraphics pg, PImage img, float x, float y, float innerRad, float diff, float rectW, int npoints, float shiftDeg) {

  main = createGraphics(width, height);
  main.beginDraw();
  main.imageMode(CENTER);

  main.tint(lerpColor(#fcecc7, #bf5d01, 0 + noise(fC_12/2) * 0.2));
  PImage kflower = getFrameBounceLast(mercy_kflower, 12, fC_12);
  float mult = 0.5;
  ellipseImage(main, kflower, origin.x, origin.y, 150, kflower.height * mult, kflower.width * mult, 10, 0, true);

  main.tint(lerpColor(#fcecc7, #bf5d01, 0.4 + noise(fC_12/2) * 0.2));
  PImage kflower2 = getFrameBounceLast(mercy_kflower, 14, fC_12);
  float mult2 = 0.45;
  ellipseImage(main, kflower2, origin.x, origin.y, 465, kflower2.height * mult2, kflower2.width * mult2, 25, 0, true);

  main.tint(lerpColor(#fcecc7, #bf5d01, 0.8 + noise(fC_12/2) * 0.2));
  PImage kflower3 = getFrame(mercy_kflower, 0, fC_12);
  float mult3 = 0.6;
  ellipseImage(main, kflower3, origin.x, origin.y, 810, kflower3.height * mult3, kflower3.width * mult3, 35, 0, true);

  main.endDraw();
  image(main, origin.x, origin.y);

  if (fC_12 < 100) {
    save("save/"+String.format("%04d", frameCount)+".png");
  }
}

/* 
 * Draws several flowers inside each other, moving in animated fashion.
 */
void drawNestedFlower(float fC_12) {
  main = createGraphics(width, height);
  main.beginDraw();
  main.imageMode(CENTER);

  float xm = map(mouseX, 0, width, -200, 200);
  float ym = map(mouseY, 0, height, -200, 200);

  color color1 = #ffc740;
  color black = #000000;
  color color2 = #bf5d01;

  float xShift_start = 550;
  float yShift_start = 550;
  float xShift_start2 = -100;
  float yShift_start2 = -100;

  float transitionAFrames = 30;
  float transitionBFrames = 35;

  float xShift, yShift;

  if (fC_12 <= transitionAFrames) {
    xShift = xShift_start - (xShift_start/transitionAFrames) * fC_12;
    yShift = yShift_start - (yShift_start/transitionAFrames) * fC_12;
  }
  else if (fC_12 < transitionAFrames + transitionBFrames) {
    float framesOfTransition = fC_12 - transitionAFrames;
    xShift = lerp(0, xShift_start2, framesOfTransition/transitionBFrames);
    yShift = lerp(0, yShift_start2, framesOfTransition/transitionBFrames);
  }
  else {
    // cos(xShift_start2 * 0.1 + 1.35398) = approx. 0
    xShift = xShift_start2 + cos(fC_12 * 0.1 + 1.35398) * 105; 

    // sin(yShift_start2 * 0.1 - 0.216815) = approx. 0
    yShift = yShift_start2 + sin(fC_12 * 0.1 - 0.216815) * 105;
  }

  for (int i = 8; i > 0; i--) {
    color c = lerpColor(color1, color2, i * (1.0/7));
    main.stroke(c);
    main.fill(black);

    flower(main, origin.x, origin.y, 11 + i * 2,
    5 + i * 3, 1 + i, 360, yShift, xShift);
  }

  main.endDraw();
  image(main, origin.x, origin.y);

  if (fC_12 < 200) {
    main.save("save/"+String.format("%04d", frameCount)+".png");
  }
}