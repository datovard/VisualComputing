/*********************************
* Vertex-Vertex Mesh representation
* Made by Dorian Tovar
* As seen in "Explicit Vertex representation (Vertex-Vertex Meshes)" on:
* http://glasnost.itcarlow.ie/~powerk/GeneralGraphicsNotes/meshes/polygon_meshes.html
*********************************/

class VertexVertexMesh {
  // Golden Ratio
  private float phi;
  
  // Size of edges in the figure
  private float c;
  
  //Vertex-Vertex List
  private ArrayList<PVector> vvList;
  
  PShape retainedModel;
  
  VertexVertexMesh(){
    phi = 1.61803398874;
    c = 50.0;
    
    vvList = new ArrayList<PVector>();
    
    // 1 - ( 0, -c, phi*c )
    // 2 - ( c, -phi*c, 0 )
    // 3 - ( -c, -phi*c, 0 )
    // 4 - ( -phi*c, 0, c )
    // 5 - ( -phi*c, 0, -c )
    // 6 - ( 0, -c, -phi*c )
    // 7 - ( phi*c, 0, -c )
    // 8 - ( phi*c, 0, c )
    // 9 - ( 0, c, phi*c )
    // 10 - ( 0, c, -phi*c )
    // 11 - ( -c, phi*c, 0 )
    // 12 - ( c, phi*c, 0 )
    
    // Filling Vertex-Vertex List 
    //A
    vvList.add( new PVector( 0, -c, phi*c ) );  // 1
    vvList.add( new PVector( c, -phi*c, 0 ) );  // 2
    vvList.add( new PVector( -c, -phi*c, 0 ) ); // 3
    
    //B
    vvList.add( new PVector( 0, -c, phi*c ) );  // 1 
    vvList.add( new PVector( -c, -phi*c, 0 ) ); // 3
    vvList.add( new PVector( -phi*c, 0, c ) );  // 4
    
    //C
    vvList.add( new PVector( -c, -phi*c, 0 ) ); // 3
    vvList.add( new PVector( -phi*c, 0, -c ) ); // 5
    vvList.add( new PVector( -phi*c, 0, c ) );  // 4
    
    //D
    vvList.add( new PVector( -c, -phi*c, 0 ) ); // 3
    vvList.add( new PVector( 0, -c, -phi*c ) ); // 6
    vvList.add( new PVector( -phi*c, 0, -c ) ); // 5
    
    //E
    vvList.add( new PVector( -c, -phi*c, 0 ) ); // 3
    vvList.add( new PVector( c, -phi*c, 0 ) );  // 2
    vvList.add( new PVector( 0, -c, -phi*c ) ); // 6
    
    //F
    vvList.add( new PVector( 0, -c, -phi*c ) ); // 6
    vvList.add( new PVector( c, -phi*c, 0 ) );  // 2
    vvList.add( new PVector( phi*c, 0, -c ) );  // 7
    
    //G
    vvList.add( new PVector( c, -phi*c, 0 ) ); // 2
    vvList.add( new PVector( phi*c, 0, c ) );  // 8
    vvList.add( new PVector( phi*c, 0, -c ) ); // 7
    
    //H
    vvList.add( new PVector( c, -phi*c, 0 ) ); // 2
    vvList.add( new PVector( 0, -c, phi*c ) ); // 1
    vvList.add( new PVector( phi*c, 0, c ) );  // 8
    
    //I
    vvList.add( new PVector( 0, -c, phi*c ) ); // 1
    vvList.add( new PVector( -phi*c, 0, c ) ); // 4
    vvList.add( new PVector( 0, c, phi*c ) );  // 9
    
    //J
    vvList.add( new PVector( 0, -c, -phi*c ) ); // 6
    vvList.add( new PVector( 0, c, -phi*c ) );  // 10
    vvList.add( new PVector( -phi*c, 0, -c ) ); // 5
    
    //K
    vvList.add( new PVector( 0, -c, -phi*c ) ); // 6
    vvList.add( new PVector( phi*c, 0, -c ) );  // 7
    vvList.add( new PVector( 0, c, -phi*c ) );  // 10
    
    //L
    vvList.add( new PVector( 0, -c, phi*c ) ); // 1
    vvList.add( new PVector( 0, c, phi*c ) );  // 9
    vvList.add( new PVector( phi*c, 0, c ) );  // 8
    
    //M
    vvList.add( new PVector( 0, c, phi*c ) );  // 9
    vvList.add( new PVector( -c, phi*c, 0 ) ); // 11
    vvList.add( new PVector( c, phi*c, 0 ) );  // 12
    
    //N
    vvList.add( new PVector( 0, c, phi*c ) );  // 9
    vvList.add( new PVector( -phi*c, 0, c ) ); // 4
    vvList.add( new PVector( -c, phi*c, 0 ) ); // 11
    
    //O
    vvList.add( new PVector( -c, phi*c, 0 ) );  // 11
    vvList.add( new PVector( -phi*c, 0, c ) );  // 4
    vvList.add( new PVector( -phi*c, 0, -c ) ); // 5
    
    //P
    vvList.add( new PVector( -c, phi*c, 0 ) );  // 11
    vvList.add( new PVector( -phi*c, 0, -c ) ); // 5
    vvList.add( new PVector( 0, c, -phi*c ) );  // 10
    
    //Q
    vvList.add( new PVector( -c, phi*c, 0 ) ); // 11
    vvList.add( new PVector( 0, c, -phi*c ) ); // 10
    vvList.add( new PVector( c, phi*c, 0 ) );  // 12
    
    //R
    vvList.add( new PVector( 0, c, -phi*c ) ); // 10
    vvList.add( new PVector( phi*c, 0, -c ) ); // 7
    vvList.add( new PVector( c, phi*c, 0 ) );  // 12
    
    //S
    vvList.add( new PVector( c, phi*c, 0 ) );  // 12
    vvList.add( new PVector( phi*c, 0, -c ) ); // 7
    vvList.add( new PVector( phi*c, 0, c ) );  // 8
    
    //T
    vvList.add( new PVector( c, phi*c, 0 ) ); // 12
    vvList.add( new PVector( phi*c, 0, c ) ); // 8
    vvList.add( new PVector( 0, c, phi*c ) ); // 9
    
    retainedModel = createShape();
    retainedModel.beginShape(TRIANGLE);
    retainedModel.fill(0, 0, 255);
    retainedModel.noStroke();    
    for( PVector v : vvList )
      retainedModel.vertex( v.x, v.y, v.z );
    retainedModel.endShape();
  }
  
  int getSize(){
    return vvList.size();
  }
  
  PVector getVertex( int index ){
    return vvList.get(index);
  }
  
  void draw( boolean retained ){
    if( retained ) {
      shape(retainedModel);
    }else{
      fill(255, 0, 0);
      noStroke();
      beginShape(TRIANGLE);
      for( PVector v : vvList )
        vertex( v.x, v.y, v.z );
      endShape();
    }
  }
}