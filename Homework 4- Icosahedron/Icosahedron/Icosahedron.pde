VertexVertexMesh vvMesh;
FaceVertexMesh fvMesh;
ExplicitMesh exMesh;
WingedEdgeMesh weMesh;

boolean retained = false;
int mode = 0;

void setup() {
  size(600, 600, P3D);
  vvMesh = new VertexVertexMesh();
  fvMesh = new FaceVertexMesh();
  exMesh = new ExplicitMesh();
  weMesh = new WingedEdgeMesh();
}

void draw() {
  background(0);
  
  text("Mesh mode: " + mode + ". Rendering mode: " + (retained ? "retained" : "immediate") + ". FPS: " + frameRate, 10 ,10);
  
  lights();
  
  translate(width/2, height/2, 0);
  //rotateX(frameCount*radians(90) / 50);
  rotateY((frameCount)*radians(90) / 50);
  
  switch( mode ){
    case 0:
      exMesh.draw(retained);
      break;
    case 1:
      vvMesh.draw(retained);
      break;
    case 2:
      fvMesh.draw(retained);
      break;
    case 3:
      weMesh.draw(retained);
      break;
  }
}


/*void draw() {
  background(0);
  
  // draw the mesh at the canvas center
  // while performing a little animation
  translate(width/2, height/2, 0);
  rotateX(frameCount*radians(90) / 50);
  rotateY(frameCount*radians(90) / 50);
  // mesh draw method
  mesh.draw();
}*/

void keyPressed() {
  if (key == ' ')
    mode = mode < 3 ? mode+1 : 0;
  if (key == 'r')
    retained = !retained;
  /*if (key == 'b')
    mesh.boundingSphere = !mesh.boundingSphere;*/
}