VertexVertexMesh vvMesh;
FaceVertexMesh fvMesh;
ExplicitMesh exMesh;

void setup() {
  size(600, 600, P3D);
  vvMesh = new VertexVertexMesh();
  fvMesh = new FaceVertexMesh();
  exMesh = new ExplicitMesh();
}

void draw() {
  background(255);
  lights();
  
  translate(width/2, height/2, 0);
  //rotateX(frameCount*radians(90) / 50);
  rotateY((frameCount)*radians(90) / 50);
  //vvMesh.draw();
  //fvMesh.draw();
  exMesh.draw();
}