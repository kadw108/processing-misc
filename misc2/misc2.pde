import java.util.Arrays;

PVector origin;
color gold = #fcc205;

color darkgold_c = #d8a93c;
color gold_c = #fcc205;

int w;

// animation runs at / is saved at frameRateConst frames per second
// due to frameRate(frameRateConst) call
float frameRateConst = 12;

PImage xCircle;
PImage[] karma;
PImage[] glyphs;

PImage bg;

PenroseLSystem ds;
ParticleSystem ps;

PGraphics main;

KarmaChar[][] karmaArray;

// begin custom

// end custom

color darkline_c;
color cat_c;

PVector catPos;

void setup(){
  // size(400, 400, P3D);
  size(1357, 1150);

  origin = new PVector(width/2, height/2);

  xCircle = loadImage("../0rw_data/xCircle3.png");
  bg = loadImage("../0rw_data/sky2.jpg");
  // bg.resize(2664, 1689);
  
  karma = loadKarma();
  glyphs = loadRange("../0rw_data/glyph-alphabet-", 1, 89, ".png", 1);

  darkline_c = #1e0505;
  cat_c = #dedcc7;

  /* --- */

  /* LOAD IN IMAGES */

  // PImage[] loadRange(String name, int start, int end, String extension, int skip)

  /* --- positions --- */

  catPos = new PVector(origin.x, origin.y);
  // catPos = new PVector(0, 0);

  /* --- */

  frameRate(frameRateConst);
  
  ds = new PenroseLSystem();
  ds.simulate(5);
  
  ps = new ParticleSystemF(new PVector(origin.x, origin.y));
  
  // imageMode(CENTER);

  main = createGraphics(width, height);
  main.beginDraw();
}

/* ------------------------------- DRAW | DRAW | DRAW ---------------------------- */

void draw(){
  int fC_6 = (int) ((6 * frameCount) / frameRateConst); // increments 6 times per second
  int fC_8 = (int) ((8 * frameCount) / frameRateConst); // increments 8 times per second
  int fC_12 = (int) ((12 * frameCount) / frameRateConst); // increments 12 times per second
  int fC_24 = (int) ((24 * frameCount) / frameRateConst); // increments 24 times per second
  int fC_30 = (int) ((30 * frameCount) / frameRateConst); // increments 30 times per second
  int fC_48 = (int) ((48 * frameCount) / frameRateConst); // increments 48 times per second
  int fC_60 = (int) ((60 * frameCount) / frameRateConst); // increments 60 times per second
  float seconds = frameCount/frameRateConst;

  background(#000000);

  int frameCountVar = fC_12 - 1;
  /*
  if (frameCountVar >= 0) {
  } */
  
  karmaPixelSequenceFromImage("../data/temp.jpg");

  print("Seconds:", seconds, "| framecount:", frameCount, "| frameCountVar:", frameCountVar, "\n");
}
