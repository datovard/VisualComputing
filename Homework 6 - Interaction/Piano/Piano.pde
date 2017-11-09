import remixlab.proscene.*;

Scene scene;
//Choose FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  size(800, 600, renderer);
  //Scene instantiation
  scene = new Scene(this);
  // when damping friction = 0 -> spin
  scene.eyeFrame().setDamping(0);
  //println("spinning sens: " +  scene.eyeFrame().spinningSensitivity());
}

void draw() {
  background(0);
  fill(204, 102, 0, 150);
  
  Octave oct1 = new Octave( -60, -80, 0, 1 );
  oct1.draw();
  
  Octave oct2 = new Octave( -60, -20, 0, 2 );
  oct2.draw();
  
  Octave oct3 = new Octave( -60, 40, 0, 3 );
  oct3.draw();
  
  Octave oct4 = new Octave( -60, 100, 0, 4 );
  oct4.draw();

  //scene.drawTorusSolenoid();
}

void keyPressed() {
  if(scene.eyeFrame().damping() == 0)
    scene.eyeFrame().setDamping(0.5);
  else
    scene.eyeFrame().setDamping(0);
  println("Camera damping friction now is " + scene.eyeFrame().damping());
}