/*************************************
* Object transformations in 3D 
* Code by: Dorian Abad Tovar
* Based on "Transformations" in visualcomputing.github.io
* http://visualcomputing.github.io/Transformations/#/themes
**************************************/

// Global Variables
int mode = 0;
boolean applyMatrix = true;

// Global translate point
float xr, yr, zr;

void setup() {
  size(1000, 800, P3D);
  xr = width/2;
  yr = height/2;
  zr = 0.0;
}

void draw() {
  background(0);
  
  String modeName ="";
  switch(mode){
    case 0:
      modeName = "Translate";
      break;
    case 1:
      modeName = "  Scaling";
      break;
    case 2:
      modeName = " Rotating";
      break;
    case 3:
      modeName = " Shearing";
      break;
  }
  
  fill(255);
  text("Transformation mode: " + modeName, 10 ,15);
  
  switch( mode ){
    case 0:
      translateFigure( xr, yr, zr );
      break;
    case 1:
      scalingFigure( 3.0, 3.0, 3.0 );
      break;
    case 2:
      rotatingFigure( 1.0, 1.0, 1.0, 30.0 );
      break;
    case 3:
      shearingFigure( 1.5, 0.7 );
      break;
  }
}

void keyPressed() {
  if (key == 't')
    mode = mode < 3 ? mode+1 : 0;
}

void axes() {
  pushStyle();
  
  // X-Axis
  strokeWeight(4);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  line(0, 0, 100, 0);//horizontal red X-axis line
  text("X", 100 + 5, 0);
  
  // Y-Axis
  stroke(0, 0, 255);
  fill(0, 0, 255);
  line(0, 0, 0, 100);//vertical blue Y-axis line
  text("Y", 0, 100 + 15);
  
  popStyle();
}

void setFigure(){
  stroke(255);
  noFill();
  box(100);
}

void translateFigure( float dx, float dy, float dz ){
  // Setting axes for reference
  axes();
  
  if( applyMatrix ){
    // Doing rotation as T( dx, dy, dz )
    // Using translation matrix
    // 1. T( dx, dy, dz )
    applyMatrix(
       1,  0,  0,  dx,
       0,  1,  0,  dy,
       0,  0,  1,  dz,
       0,  0,  0,   1
    );
  }else{
    // Using Processing built-in translate method
    // 1. T( dx, dy, dz )
    translate(dx, dy, dz);
  }
  
  // Draw the figure
  setFigure();
}

void scalingFigure( float sx, float sy, float sz ){
  // Setting axes for reference
  axes();
  
  if( applyMatrix ){
    // Doing scaling as T( dx, dy, dz )S( sx, sy, sz )T( -dx, -dy, -dz )
    // Using transformation matrices
    // 1. T( dx, dy, dz )
    applyMatrix(
       1,  0,  0,  xr,
       0,  1,  0,  yr,
       0,  0,  1,  zr,
       0,  0,  0,   1
    );
    // 2. S( sx, sy, sz )
    applyMatrix(
      sx,  0,  0,  0,
       0, sy,  0,  0,
       0,  0, sz,  0,
       0,  0,  0,  1
    );
    // 3. T( -dx, -dy, -dz )
    applyMatrix(
       1,  0,  0,  0,
       0,  1,  0,  0,
       0,  0,  1,  0,
       0,  0,  0,  1
    );
  }else{
    // Using Processing built-in translate and scale methods
    // 1. T( dx, dy, dz )
    translate( xr, yr, zr );
    // 2. S( sx, sy, sz )
    scale( sx, sy, sz );
    // 3. T( -dx, -dy, -dz )
    translate( -xr, -yr, -zr );
  }
  
  // Draw the figure
  setFigure();
}

void rotatingFigure( float va, float vb, float vc, float beta ){
  // Setting axes for reference
  axes();
  
  float ua, ub, uc;
  ua = (float) (va/( Math.sqrt( (va*va)+(vb*vb)+(vc*vc) ) ));
  ub = (float) (vb/( Math.sqrt( (va*va)+(vb*vb)+(vc*vc) ) ));
  uc = (float) (vc/( Math.sqrt( (va*va)+(vb*vb)+(vc*vc) ) ));
  
  double d       = Math.sqrt( (ub*ub)+(uc*uc) );
  double alpha   = Math.asin( ub/d );
  double lambda  = Math.asin( ua );
  
  if( applyMatrix ){
    // Doing scaling as T( dx, dy, dz )Rx( -alpha )Ry( -lambda )Rz( beta )Ry( lambda )Rx( alpha )T( -dx, -dy, -dz )
    // Using transformation matrices
    // 1. T( dx, dy, dz )
    applyMatrix(
       1,  0,  0,  xr,
       0,  1,  0,  yr,
       0,  0,  1,  zr,
       0,  0,  0,   1
    );
    // 2. Rx( -alpha )
    applyMatrix(
       1,                         0,                             0,  0,
       0, (float)(Math.cos(-alpha)),  (float)(-1*Math.sin(-alpha)),  0,
       0, (float)(Math.sin(-alpha)),     (float)(Math.cos(-alpha)),  0,
       0,                         0,                             0,  1
    );
    // 3. Ry( -lambda )
    applyMatrix(
          (float)(Math.cos(-lambda)),  0,  (float)(Math.sin(-lambda)),  0,
                                   0,  1,                           0,  0,
       (float)(-1*Math.sin(-lambda)),  0,  (float)(Math.cos(-lambda)),  0,
                                   0,  0,                           0,  1
    );
    // 4. Rz( beta )
    applyMatrix(
       (float)(Math.cos(beta)),  (float)(-1*Math.sin(beta)),  0,  0,
       (float)(Math.sin(beta)),     (float)(Math.cos(beta)),  0,  0,
                             0,                           0,  1,  0,
                             0,                           0,  0,  1
    );
    // 5. Ry( lambda )
    applyMatrix(
          (float)(Math.cos(lambda)),  0,  (float)(Math.sin(lambda)),  0,
                                   0, 1,                           0, 0,
       (float)(-1*Math.sin(lambda)),  0,  (float)(Math.cos(lambda)),  0,
                                   0, 0,                           0, 1
    );
    // 6. Rx( alpha )
    applyMatrix(
       1,                        0,                            0, 0,
       0, (float)(Math.cos(alpha)),  (float)(-1*Math.sin(alpha)), 0,
       0, (float)(Math.sin(alpha)),     (float)(Math.cos(alpha)), 0,
       0,                        0,                            0, 1
    );
    // 7. T( -dx, -dy, -dz )
    applyMatrix(
       1,  0,  0,  0,
       0,  1,  0,  0,
       0,  0,  1,  0,
       0,  0,  0,  1
    );
  }else{
    // Using Processing built-in translate and rotate methods
    // 1. T( dx, dy, dz )
    translate(xr, yr, zr);
    // 2. Rx( -alpha )
    rotateX( (float) -alpha );
    // 3. Ry( -lambda )
    rotateY( (float) -lambda );
    // 4. Rz( beta )
    rotateZ( (float) beta );
    // 5. Ry( lambda )
    rotateY( (float) lambda );
    // 6. Rx( alpha )
    rotateX( (float) alpha );
    // 7. T( -dx, -dy, -dz )
    translate( 0, 0, 0 );
  }
  
  // Draw the figure
  setFigure();
}

void shearingFigure( float a, float b ){
  // Setting axes for reference
  axes();
  
  // Doing scaling as T( dx, dy, dz )Dz( a, b, 0 )T( -dx, -dy, -dz )
  // Using transformation matrices
  // 1. T( dx, dy, dz )
  applyMatrix(
    1,  0,  0,  xr,
    0,  1,  0,  yr,
    0,  0,  1,  zr,
    0,  0,  0,   1
  );
  // 2. Dz( a, b, 0 )
  applyMatrix(
    1,  0,  a,  0,
    0,  1,  b,  0,
    0,  0,  1,  0,
    0,  0,  0,  1
  );
  // 3. T( -dx, -dy, -dz )
  applyMatrix(
    1,  0,  0,  0,
    0,  1,  0,  0,
    0,  0,  1,  0,
    0,  0,  0,  1
  );
  
  // Draw the figure
  setFigure();
  
}