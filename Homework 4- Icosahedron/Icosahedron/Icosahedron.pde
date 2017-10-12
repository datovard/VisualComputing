VertexVertexMesh vvMesh;
FaceVertexMesh fvMesh;
ExplicitMesh exMesh;
WingedEdgeMesh weMesh;

boolean retained = false;
int mode = 0;
int visualize = 0;

void setup() {
  size(600, 600, P3D);
  vvMesh = new VertexVertexMesh();
  fvMesh = new FaceVertexMesh();
  exMesh = new ExplicitMesh();
  weMesh = new WingedEdgeMesh();
  frameRate(1000);
}

void draw() {
  background(0);
  String modeName ="";
  switch(mode){
    case 0:
      modeName = "     Explicit Mesh";
      break;
    case 1:
      modeName = "Vertex-Vertex Mesh";
      break;
    case 2:
      modeName = "  Face-Vertex Mesh";
      break;
    case 3:
      modeName = "  Winged-Edge Mesh";
      break;
  }
  
  text("Mesh mode: " + modeName + ". Rendering mode: " + (retained ? "retained" : "immediate") + ". FPS: " + frameRate, 10 ,10);
  
  lights();
  
  translate(width/2, height/2, 0);
  //rotateX(frameCount*radians(90) / 50);
  rotateY(frameCount*radians(90) / 50);
  
  switch( mode ){
    case 0:
      exMesh.draw( retained, visualize );
      break;
    case 1:
      vvMesh.draw( retained, visualize );
      break;
    case 2:
      fvMesh.draw( retained, visualize );
      break;
    case 3:
      weMesh.draw( retained, visualize );
      break;
  }
}


void keyPressed() {
  if (key == ' ')
    mode = mode < 3 ? mode+1 : 0;
  if (key == 'r')
    retained = !retained;
  if (key == 'v')
    visualize = visualize < 3 ? visualize+1 : 0;
  /*if (key == 'b')
    mesh.boundingSphere = !mesh.boundingSphere;*/
}