import remixlab.proscene.*;
//import remixlab.dandelion.*;
import remixlab.dandelion.geom.Rect;
import remixlab.dandelion.core.GenericFrame;
import remixlab.dandelion.geom.Vec;
import remixlab.bias.*;

Scene scene;

void setup() {
  size(1000, 700, P3D);
  scene = new Scene(this);
  scene.eyeFrame().setDamping(0);
  
  scene.toggleGridVisualHint();
}

void draw(){
  background(0);
  
  scene.drawCylinder(5, 50);
  
}