/*! @preserve
 * android_clock.pde
 * version : 1.0.0
 * author : Symsey Cruz
 * license :
 *
 */

int secArcD = 840;
int minArcD = secArcD - 50;
int hourArcD = minArcD - 50;
float beginIndex = (-1.5708); //radian of -90 degrees
float endIndexSec, endIndexMin, endIndexHr = beginIndex;

// processing built-in method. see processing.org
void settings() {
  fullScreen(); // sets to fullscreen
}

// processing built-in method. see processing.org
void setup() {
  PFont font = createFont("SansSerif", 24 * displayDensity);
  textFont(font);
  textAlign(CENTER, CENTER);
}

// processing built-in method. see processing.org
// it loops synchronized to monitor refreshrate.
void draw() {
  background(0);
  translate( width / 2, height / 2 );
  strokeCap( SQUARE );

  int hr = hour();
  int mn = minute();
  int sc = second();

  // render seconds arc
  noFill();
  stroke( 249, 49, 112 );
  strokeWeight( 25 );
  float secAngle = map( sc, 0, 60, 0, 360 );

  // condition occur because the method radians return zero if the angle is 360 degrees
  float newSecAngle = (radians(secAngle) == 0) ? 6.28319 : radians(secAngle);

  // do tailing effect when reached full rotation;
  if(newSecAngle == 6.28319f) {
    arc( 0, 0, secArcD, secArcD, endIndexSec,  newSecAngle+beginIndex);
    endIndexSec = endIndexSec+0.095;
  }
  else {
    arc( 0, 0, secArcD, secArcD, beginIndex,  newSecAngle+beginIndex); //newSecAngle+beginIndex
    endIndexSec = beginIndex;
  }

  // render minute arc
  noFill();
  stroke( 0, 230, 64 );
  strokeWeight( 25 );
  float mnAngle = map( mn, 0, 60, 0, 360 ) + map( secAngle, 0, 360, 0, 6 ); // to make more realistic

  // condition occur because the method radians return zero if the angle is 360 degrees
  float newMnAngle = (radians(mnAngle) == 0) ? 6.28319 : radians(mnAngle);

  // do tailing effect when reached full rotation;
  if(newMnAngle == 6.28319f) {
    arc( 0, 0, minArcD, minArcD, endIndexMin, newMnAngle+beginIndex );
    endIndexMin = endIndexMin+0.095;
  }
  else {
    arc( 0, 0, minArcD, minArcD, beginIndex, newMnAngle+beginIndex );
    endIndexMin = beginIndex;
  }

  // render hour arc
  noFill();
  stroke( 34, 167, 240 );
  strokeWeight( 25 );
  float hrAngle = map( hr % 12, 0, 12, 0, 360 ) + map( mnAngle, 0, 360, 0, 30 );

  // condition occur because the method radians return zero if the angle is 360 degrees
  float newHrAngle = (radians(hrAngle) == 0) ? 6.28319 : radians(hrAngle);

  // do tailing effect when reached full rotation;
  if(newHrAngle == 6.28319f) {
    arc( 0, 0, hourArcD, hourArcD, endIndexHr, newHrAngle+beginIndex );
    endIndexHr = endIndexHr+0.095;
  }
  else {
    arc( 0, 0, hourArcD, hourArcD, beginIndex, newHrAngle+beginIndex );
    endIndexHr = beginIndex;
  }

  // render time in text format
  text(formatTime( hr+"", mn+"", sc+""), 0, 0);
}

String formatTime ( String hr, String mn, String sc ) {
  if(mn.length() != 2) mn = "0" + mn;
  if(sc.length() != 2) sc = "0" + sc;
  return hr + " : " + mn + " : " + sc;
}
