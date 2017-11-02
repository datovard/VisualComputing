/***************************************
* Cow-Abduction by Dorian Abad Tovar
* Based in Scene-Graph representation
* Found in visualcomputing.github.io
* http://visualcomputing.github.io/Transformations/#/6
* Scene-Graph
*
* World: Farm
*  ^       ^
*  |        \
*  |         \
* G1: UFO    Eye
*  |
*  |
* G2: Light
*  |
*  |
* G3: Cow
***************************************/

// Images
PImage ufo;
PImage cow;
PImage farm;

int cow_x, cow_y;
float cow_scale;
int light_width;
float ufo_scale;

boolean abduct_cow;
boolean close_light;
boolean move_ufo;
boolean finished_animation;

PGraphics canvas1, canvas2;

//eye params
PVector eyePosition = new PVector();
float eyeOrientation = 0;
float eyeScaling = 0.5;

void setup() {
  size(1000, 800, P2D);
  
  canvas1 = createGraphics(width, height, P2D);
  canvas2 = createGraphics(width/2, height/2, P2D);
  
  ufo = loadImage("ovni.png");
  cow = loadImage("vaca.png");
  farm = loadImage("granja.jpg");
  
  resetEye();
  
  resetParams();
}

void draw() {
  
  canvas1.beginDraw();
  
  canvas1.background(0);
  
  // Scaling the world with zoom
  canvas1.scale(1/eyeScaling);
  
  // Rotating the scene
  canvas1.rotate(-eyeOrientation);
  
  // Moving the scene with the position of the mouse
  canvas1.translate(-eyePosition.x, -eyePosition.y);
  
  // Draw the abduction scene
  drawSceneWorld( canvas1 );
  
  if ( eyeScaling < 1.0 ) {
    eyePosition.x = mouseX;
    eyePosition.y = mouseY;
  }
  
  canvas1.endDraw();
  // Print scene onto the screen
  image( canvas1, 0, 0 );
}

void keyPressed() {
  if (key == 'r')
    resetEye();
  if (key == CODED)
    if (keyCode == UP)
      eyeScaling /= 1.1;
    else if (keyCode == DOWN)
      eyeScaling *= ( eyeScaling == 1 )? 1: 1.1;
    else if (keyCode == LEFT)
      eyeOrientation += .1;
    else if (keyCode == RIGHT)
      eyeOrientation -= .1;
}

void drawSceneWorld(PGraphics pg) {
  // Color of the light
  color c = color( 255, 255, 255, 150 );
  
  if( abduct_cow ){
    cow_y -= 2;
    cow_scale -= 0.0046;
    if( cow_y <= 0 )
      abduct_cow = false;
  }else{
    close_light = true;
  }
  
  if( close_light && !abduct_cow ){
    if( light_width <= 0 ){
      close_light = false;
      move_ufo = true;
    }else{
      light_width -= 5;
    }
  }
  
  if( move_ufo ){
    if( ufo_scale <= 0 ){
      move_ufo = false;
      finished_animation = true;
    }else{
      ufo_scale -= 0.01;
    }
  }
  
  if( finished_animation ) resetParams();
  
  
  // WORLD - Farm
  pg.pushMatrix();
  pg.image( farm, 0, 0, width, height );
    
    // G1 - UFO
    pg.pushMatrix();
    pg.scale(ufo_scale);
    pg.translate( width/2 + 100, height/2 - 300 );
    pg.image( ufo, -235, -175, 470, 350 );
      
      // G2 - Light
      if( !move_ufo ){
        pg.pushMatrix();
        pg.translate( -40, 150 );
        pg.fill( c );
        pg.noStroke();
        pg.rotate(PI/6);
        pg.triangle( 0, 0, -light_width, 800, light_width, 800 );
          
          // G3 - Cow
          if( abduct_cow ){
            pg.pushMatrix();
            pg.scale( cow_scale );
            pg.translate( cow_x, cow_y );
            pg.image( cow, -75, -50, 150, 100 );
            pg.popMatrix();
          }
        
        pg.popMatrix();
      }
    
    pg.popMatrix();
  
  pg.popMatrix();
}

void drawEye() {
  canvas1.pushStyle();
  // define an eye frame L1 (respect to the world)
  canvas1.pushMatrix();
  // the position of the minimap rect is defined according to eye parameters as:
  // T(eyePosition)*R(eyeOrientation)*S(eyeScaling)
  canvas1.translate(eyePosition.x, eyePosition.y);
  canvas1.rotate(eyeOrientation);
  canvas1.scale(eyeScaling);
  canvas1.stroke(0, 255, 0);
  canvas1.strokeWeight(8);
  canvas1.noFill();
  canvas1.rect(0, 0, canvas2.width, canvas2.height);
  // return to World
  canvas1.popMatrix();
  canvas1.popStyle();
}

void resetParams() {
  cow_x = 0;
  cow_y = 450;
  cow_scale = 1;
  abduct_cow = true;
  
  light_width = 250;
  close_light = false;
  
  ufo_scale = 1.0;
  move_ufo = false;
  
  finished_animation = false;
}

void resetEye() {
  eyePosition = new PVector();
  eyeOrientation = 0;
  eyeScaling = 1.0;
}