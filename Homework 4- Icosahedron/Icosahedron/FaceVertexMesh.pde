/*********************************
* Face-Vertex Mesh representation
* Made by Dorian Tovar
* As seen in "Index to Vertex List (Face-Vertex Meshes)" on:
* http://glasnost.itcarlow.ie/~powerk/GeneralGraphicsNotes/meshes/polygon_meshes.html
*********************************/
class FaceVertexMesh {
  //Face-Vertex Mesh representation
  
  // Golden Ratio
  private float phi;
  
  // Size of edges in the figure
  private float c;
  
  // Map of every Vertex in the figure
  private HashMap< Integer, PVector > vertices;
  
  //Face-Vertex Indexes List
  private ArrayList<Integer> vvList;
  
  PShape retainedModel;
  
  FaceVertexMesh(){
    phi = 1.61803398874;
    c = 50.0;
    
    vertices = new HashMap<Integer, PVector>();
    vvList = new ArrayList<Integer>();
    
    vertices.put( 1, new PVector( 0, -c, phi*c ) );
    vertices.put( 2, new PVector( c, -phi*c, 0 ) );
    vertices.put( 3, new PVector( -c, -phi*c, 0 ) );
    vertices.put( 4, new PVector( -phi*c, 0, c ) );
    vertices.put( 5, new PVector( -phi*c, 0, -c ) );
    vertices.put( 6, new PVector( 0, -c, -phi*c ) );
    vertices.put( 7, new PVector( phi*c, 0, -c ) );
    vertices.put( 8, new PVector( phi*c, 0, c ) );
    vertices.put( 9, new PVector( 0, c, phi*c ) );
    vertices.put( 10, new PVector( 0, c, -phi*c ) );
    vertices.put( 11, new PVector( -c, phi*c, 0 ) );
    vertices.put( 12, new PVector( c, phi*c, 0 ) );
    
    
    // Filling Vertex-Vertex List 
    //A
    vvList.add( 1 );
    vvList.add( 2 );
    vvList.add( 3 );
    
    //B
    vvList.add( 1 );
    vvList.add( 3 );
    vvList.add( 4 );
    
    //C
    vvList.add( 3 );
    vvList.add( 5 );
    vvList.add( 4 );
    
    //D
    vvList.add( 3 );
    vvList.add( 6 );
    vvList.add( 5 );
    
    //E
    vvList.add( 3 );
    vvList.add( 2 );
    vvList.add( 6 );
    
    //F
    vvList.add( 6 );
    vvList.add( 2 );
    vvList.add( 7 );
    
    //G
    vvList.add( 2 );
    vvList.add( 8 );
    vvList.add( 7 );
    
    //H
    vvList.add( 2 );
    vvList.add( 1 );
    vvList.add( 8 );
    
    //I
    vvList.add( 1 );
    vvList.add( 4 );
    vvList.add( 9 );
    
    //J
    vvList.add( 6 );
    vvList.add( 10 );
    vvList.add( 5 );
    
    //K
    vvList.add( 6 );
    vvList.add( 7 );
    vvList.add( 10 );
    
    //L
    vvList.add( 1 );
    vvList.add( 9 );
    vvList.add( 8 );
    
    //M
    vvList.add( 9 );
    vvList.add( 11 );
    vvList.add( 12 );
    
    //N
    vvList.add( 9 );
    vvList.add( 4 );
    vvList.add( 11 );
    
    //O
    vvList.add( 11 );
    vvList.add( 4 );
    vvList.add( 5 );
    
    //P
    vvList.add( 11 );
    vvList.add( 5 );
    vvList.add( 10 );
    
    //Q
    vvList.add( 11 );
    vvList.add( 10 );
    vvList.add( 12 );
    
    //R
    vvList.add( 10 );
    vvList.add( 7 );
    vvList.add( 12 );
    
    //S
    vvList.add( 12 );
    vvList.add( 7 );
    vvList.add( 8 );
    
    //T
    vvList.add( 12 );
    vvList.add( 8 );
    vvList.add( 9 );
    
    retainedModel = createShape();
    retainedModel.beginShape(TRIANGLE);
    retainedModel.noFill();
    for( Integer i : vvList )
      retainedModel.vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    retainedModel.endShape();
  }
  
  int getSize(){
    return vertices.size();
  }
  
  PVector getVertex( int index ){
    return vertices.get(index);
  }
  
  void draw(){
    fill(255, 0, 0, 200);
    beginShape(TRIANGLE);
    for( Integer i : vvList )
      vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    endShape();
  }
}