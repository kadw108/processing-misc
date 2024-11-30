void memoryConfluxBG(PGraphics pg, float seed) {
    PVector origin = new PVector(pg.width/2, pg.height/2);
    color bgLight = #f3fdf1;
    color bg = #e3ede1;
    color bgGrey = #827A6E;
    color bgMid = lerpColor(bg, bgGrey, 0.5);
    color dark = #262626;

    float holeSize = pg.height/5.0;

    // BACKGROUND
    // void gridLines(PGraphics pg, float h, color c1, color c2, float speed, boolean horizontal) {
    /*
    gridLines(pg, 30, dark, bgLight, 1, true);
    gridLines(pg, 30, dark, bgLight, 1, false);
    */

    // GEAR AROUND HOLE
    pg.stroke(bgMid);
    pg.strokeWeight(10);
    pg.fill(bg);
    gear(pg, origin.x, origin.y, 10, holeSize + 10, 30, 180);

    // DARK HOLE
    pg.fill(dark);
    pg.stroke(bgMid);
    pg.strokeWeight(5);

    // void waveShape(PGraphics pg, float x0, float y0, float radius1, float radius2, int npoints, float seed) {
    waveShapeStill(pg, origin.x, origin.y, holeSize - 30, holeSize, 180, seed);

    // AROUND HOLE 1
    // void circleDotsMissing(PGraphics pg, float x, float y, float radDot, float radX, float radY,
    // int npoints, int circleSpace, int circleMissing) {
    float largerRadius = holeSize + 50;

    pg.stroke(bgMid);
    pg.strokeWeight(10);
    pg.noFill();
    pg.circle(origin.x, origin.y, largerRadius * 2);

    pg.fill(bg);
    pg.stroke(bgGrey);
    pg.strokeWeight(3);
    circleDotsMissing(pg, origin.x, origin.y, 60, largerRadius, largerRadius, 12, 2, 1);

    pg.stroke(bgMid);
    pg.strokeWeight(2);
    circleDotsMissing(pg, origin.x, origin.y, 45, largerRadius, largerRadius, 12, 2, 1);
}

void memoryConfluxFG(PGraphics pg, float seed) {
    PVector origin = new PVector(pg.width/2, pg.height/2);
    color bgLight = #f3fdf1;
    color bg = #e3ede1;
    color bgGrey = #827A6E;
    color bgMid = lerpColor(bg, bgGrey, 0.5);
    color dark = #262626;

    // BORDER 1
    pg.noFill();
    pg.strokeWeight(30);
    pg.stroke(dark);
    pg.rect(0, 0, pg.width, pg.height, 10);
}

/*
 * Draws a gear
 * from https://mathworld.wolfram.com/GearCurve.html and https://openprocessing.org/sketch/1775275
 *
 * toothLength - recommended value from 5-25, smaller = longer tooth
 * numPoints - number of points in circumference of gear, recommended value=360 or 180
 */
void gear(PGraphics pg, float x, float y, int numTeeth, float radius, float toothLength, float numPoints) {

	pg.beginShape();
	for (int i = 0; i < numPoints; i++) {
		float t = TWO_PI * (i / numPoints);
		float r = 1 + (1 / toothLength) * (float) Math.tanh(toothLength * sin(numTeeth * t));
		float vertX  = x + radius * r * cos(t);
		float vertY  = y + radius * r * sin(t);
		pg.vertex(vertX, vertY);
	}
	pg.endShape(CLOSE);
}
void gear(PGraphics pg, float x, float y, int numTeeth, float radius) {
    gear(pg, x, y, numTeeth, radius, 10, 360);
}
