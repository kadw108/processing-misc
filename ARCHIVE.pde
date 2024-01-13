// ARCHIVE

/*

// expanding waveShapePS over 3 seconds
// waveShapePS(float x0, float y0, float radius1, float radius2, int npoints, float seed)
PShape waveC = waveShapePS(origin.x, origin.y, seconds/3 * width * 0.5, seconds/3 * width * 0.5 * 1.2, 360, 0);
waveC.setFill(false);
waveC.setStroke(255);
waveC.setStrokeWeight(2);
main.shape(waveC);

main.endDraw();
image(main, 0, 0);

*/

/*
  // Weird combination of stuff made to show at CAC
  image(althWaves(origin.y + 100, 10, 100), 0, 0);
  
  noStroke();
  for (int i = 0; i < 10; i++) {
    columnField(2, 2, (int)(i * frameRateConst));
  }
  
  // background(0);
  // stroke(lerpColor(#1188ff, #ffffff, sin(frameCount/frameRateConst)));
  // expandingShape(#66ccff);
  
  // drawMandala(float x, float y, float radius, float radius2, color c)
  // drawMandala(origin.x, origin.y, 100, 500, lerpColor(#1188ff, #eeeeee, sin(frameCount/frameRateConst)));
  // translate(0, 0, 0.9);
  
  //growFlower(float x, float y, float w, float h, float flowerSize, int growSeconds, int startFrame, color stem, color flower)
  // image(growFlower(origin.x, origin.y, 50, 100, 20, 0, 0, gold, gold), 0, 0);
  
  noStroke();
  
  // lineFromPoints(randomCurve(500, 5, 130, -90, 0), origin.x, origin.y);
  // fernFromPoints(randomCurve(900, 5, 130, -90, 0), origin.x, origin.y + 400, 5, 1);
  // chainFromPoints(PVector[] points, float x, float y, float linkLen, float spaceBetween) {
      
  if (frameCount % 10 == 0) {
    ps.addParticleAround(3, 50);
  }
  noFill();
  stroke(lerpColor(#ffffff, #3399ff, sin(frameCount/frameRateConst)));
  ((ParticleSystemF) ps).run(flowField(100, 100, 1, frameCount/frameRateConst));
  
  fill(lerpColor(#1188ff, #ffffff, sin(frameCount/frameRateConst)));
      
  pushMatrix();
  translate(0, 0, 0);
  image(althWaves(origin.y + 100, 10, 100), 0, 0);
  popMatrix();
    
  drawMandala(origin.x, origin.y, 100, 500, lerpColor(#1188ff, #eeeeee, sin(frameCount/frameRateConst)));
  
  float fC = frameCount - 120;
  // glitchCloudCube(float x, float y, float z, float randr, float num, float size, float seed, float speed)
  glitchCloudCube(origin.x, origin.y, 0, fC / frameRateConst * 95, 50 * 0.2 * fC/frameRateConst, fC/frameRateConst * 15, frameCount, 0.1);
  */
