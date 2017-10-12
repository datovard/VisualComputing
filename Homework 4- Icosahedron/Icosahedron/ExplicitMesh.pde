/*********************************
* Explicit Mesh representation
* Made by Dorian Tovar
* As seen in "POLYGONAL MESHES REPRESENTATION - EXPLICIT REPRESENTATION" on:
* http://visualcomputing.github.io/representation/#/4/2
*********************************/
class ExplicitMesh {
  //Face-Vertex Mesh representation
  
  // Golden Ratio
  private float phi;
  
  // Size of edges in the figure
  private float c;
  
  // Map of every Vertex in the figure
  private ArrayList< ArrayList<PVector> > polygons;
  
  PShape retainedModel, retainedModel1, retainedModel2, retainedModel3;
  
  ExplicitMesh(){
    phi = 1.61803398874;
    c = 50.0;
    
    polygons = new ArrayList< ArrayList<PVector> >();
    
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
    polygons.add( new ArrayList<PVector>(){{
      add(new PVector( 0, -c, phi*c ));
      add(new PVector( c, -phi*c, 0 ));
      add(new PVector( -c, -phi*c, 0 ));
    }} );
    
    //B
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, phi*c ) );
      add( new PVector( -c, -phi*c, 0 ) );
      add( new PVector( -phi*c, 0, c ) );
    }} );
    
    //C
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, -phi*c, 0 ) );
      add( new PVector( -phi*c, 0, -c ) );
      add( new PVector( -phi*c, 0, c ) );
    }} );
    
    //D
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, -phi*c, 0 ) );
      add( new PVector( 0, -c, -phi*c ) );
      add( new PVector( -phi*c, 0, -c ) );
    }} );
    
    //E
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, -phi*c, 0 ) );
      add( new PVector( c, -phi*c, 0 ) );
      add( new PVector( 0, -c, -phi*c ) );
    }} );
    
    //F
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, -phi*c ) );
      add( new PVector( c, -phi*c, 0 ) );
      add( new PVector( phi*c, 0, -c ) );
    }} );
    
    //G
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( c, -phi*c, 0 ) );
      add( new PVector( phi*c, 0, c ) );
      add( new PVector( phi*c, 0, -c ) );
    }} );
    
    //H
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( c, -phi*c, 0 ) );
      add( new PVector( 0, -c, phi*c ) );
      add( new PVector( phi*c, 0, c ) );
    }} );
    
    //I
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, phi*c ) );
      add( new PVector( -phi*c, 0, c ) );
      add( new PVector( 0, c, phi*c ) );
    }} );
    
    //J
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, -phi*c ) );
      add( new PVector( 0, c, -phi*c ) );
      add( new PVector( -phi*c, 0, -c ) );
    }} );
    
    //K
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, -phi*c ) );
      add( new PVector( phi*c, 0, -c ) );
      add( new PVector( 0, c, -phi*c ) );
    }} );
    
    //L
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, -c, phi*c ) );
      add( new PVector( 0, c, phi*c ) );
      add( new PVector( phi*c, 0, c ) );
    }} );
    
    //M
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, c, phi*c ) );
      add( new PVector( -c, phi*c, 0 ) );
      add( new PVector( c, phi*c, 0 ) );
    }} );
    
    //N
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, c, phi*c ) );
      add( new PVector( -phi*c, 0, c ) );
      add( new PVector( -c, phi*c, 0 ) );
    }} );
    
    //O
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, phi*c, 0 ) );
      add( new PVector( -phi*c, 0, c ) );
      add( new PVector( -phi*c, 0, -c ) );
    }} );
    
    //P
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, phi*c, 0 ) );
      add( new PVector( -phi*c, 0, -c ) );
      add( new PVector( 0, c, -phi*c ) );
    }} );
    
    //Q
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( -c, phi*c, 0 ) );
      add( new PVector( 0, c, -phi*c ) );
      add( new PVector( c, phi*c, 0 ) );
    }} );
    
    //R
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( 0, c, -phi*c ) );
      add( new PVector( phi*c, 0, -c ) );
      add( new PVector( c, phi*c, 0 ) );
    }} );
    
    //S
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( c, phi*c, 0 ) );
      add( new PVector( phi*c, 0, -c ) );
      add( new PVector( phi*c, 0, c ) );
    }} );
    
    //T
    polygons.add( new ArrayList<PVector>(){{
      add( new PVector( c, phi*c, 0 ) );
      add( new PVector( phi*c, 0, c ) );
      add( new PVector( 0, c, phi*c ) );
    }} );
    
    retainedModel = createShape();
    retainedModel.beginShape(POINTS);
    retainedModel.noFill();
    retainedModel.stroke(0, 0, 255);
    retainedModel.strokeWeight(3);
    for( ArrayList<PVector> vertexList : polygons )
      for( PVector vertex: vertexList )
        retainedModel.vertex( vertex.x, vertex.y, vertex.z );
    retainedModel.endShape();
    
    retainedModel1 = createShape();
    retainedModel1.beginShape(TRIANGLES);
    retainedModel1.noFill();
    retainedModel1.stroke(255);
    retainedModel1.strokeWeight(3);
    for( ArrayList<PVector> vertexList : polygons )
      for( PVector vertex: vertexList )
        retainedModel1.vertex( vertex.x, vertex.y, vertex.z );
    retainedModel1.endShape();
    
    retainedModel2 = createShape();
    retainedModel2.beginShape(TRIANGLES);
    retainedModel2.strokeWeight(3);
    retainedModel2.fill(0, 0, 255);
    retainedModel2.noStroke();
    for( ArrayList<PVector> vertexList : polygons )
      for( PVector vertex: vertexList )
        retainedModel2.vertex( vertex.x, vertex.y, vertex.z );
    retainedModel2.endShape();
    
    
    retainedModel3 = createShape();
    retainedModel3.beginShape(TRIANGLES);
    retainedModel3.fill(0, 0, 255);
    retainedModel3.stroke(255);
    retainedModel3.strokeWeight(3);
    for( ArrayList<PVector> vertexList : polygons )
      for( PVector vertex: vertexList )
        retainedModel3.vertex( vertex.x, vertex.y, vertex.z );
    retainedModel3.endShape();
  }
  
  int getSize(){
    return polygons.size();
  }
  
  ArrayList<PVector> getPolygon( int index ){
    return polygons.get(index);
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
      for( ArrayList<PVector> vertexList : polygons )
        for( PVector vertex: vertexList )
          vertex( vertex.x, vertex.y, vertex.z );
      endShape();
    }
  }
}