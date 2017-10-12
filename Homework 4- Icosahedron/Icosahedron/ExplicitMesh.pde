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
  
  PShape retainedModel;
  
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
  }
  
  int getSize(){
    return polygons.size();
  }
  
  ArrayList<PVector> getPolygon( int index ){
    return polygons.get(index);
  }
  
  void draw( boolean retained ){
    if( retained ) {
      shape(retainedModel);
    }else{
      noFill();
      stroke(255, 0, 0);
      strokeWeight(3);
      beginShape(POINTS);
      for( ArrayList<PVector> vertexList : polygons )
        for( PVector vertex: vertexList )
          vertex( vertex.x, vertex.y, vertex.z );
      endShape();
    }
  }
}