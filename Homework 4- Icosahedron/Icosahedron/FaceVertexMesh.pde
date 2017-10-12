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
  
  PShape retainedModel, retainedModel1, retainedModel2, retainedModel3;
  
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
    retainedModel.beginShape(POINTS);
    retainedModel.noFill();
    retainedModel.stroke(0, 0, 255);
    retainedModel.strokeWeight(3);
    for( Integer i : vvList )
      retainedModel.vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    retainedModel.endShape();
    
    retainedModel1 = createShape();
    retainedModel1.beginShape(TRIANGLES);
    retainedModel1.noFill();
    retainedModel1.stroke(255);
    retainedModel1.strokeWeight(3);
    for( Integer i : vvList )
      retainedModel1.vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    retainedModel1.endShape();
    
    retainedModel2 = createShape();
    retainedModel2.beginShape(TRIANGLES);
    retainedModel2.strokeWeight(3);
    retainedModel2.fill(0, 0, 255);
    retainedModel2.noStroke();
    for( Integer i : vvList )
      retainedModel2.vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    retainedModel2.endShape();
    
    retainedModel3 = createShape();
    retainedModel3.beginShape(TRIANGLES);
    retainedModel3.fill(0, 0, 255);
    retainedModel3.stroke(255);
    retainedModel3.strokeWeight(3);
    for( Integer i : vvList )
      retainedModel3.vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
    retainedModel3.endShape();
  }
  
  int getSize(){
    return vertices.size();
  }
  
  PVector getVertex( int index ){
    return vertices.get(index);
  }
  
  void draw( boolean retained, int visualize ){
    int shapeMode;
    if( retained ) {
      switch(visualize){
        case 0:
          shape(retainedModel);
          break;
        case 1:
          shape(retainedModel1);
          break;
        case 2:
          shape(retainedModel2);
          break;
        case 3:
          shape(retainedModel3);
          break;
      }
    }else{
      shapeMode = POINTS;
      switch(visualize){
        case 0:
          noFill();
          stroke(255, 0, 0);
          strokeWeight(3);
          shapeMode = POINTS;
          break;
        case 1:
          noFill();
          stroke(255);
          strokeWeight(3);
          shapeMode = TRIANGLES;
          break;
        case 2:
          fill(255, 0, 0);
          noStroke();
          shapeMode = TRIANGLES;
          break;
        case 3:
          fill(255, 0, 0);
          stroke(255);
          strokeWeight(3);
          shapeMode = TRIANGLES;
          break;
      }
      
      beginShape(shapeMode);
      for( Integer i : vvList )
        vertex( vertices.get(i).x, vertices.get(i).y, vertices.get(i).z );
      endShape();
    }
  }
}