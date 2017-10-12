/*********************************
* Winged-Edge Mesh representation
* Made by Dorian Tovar
* As seen in "Winged-edge meshes" on:
* https://en.wikipedia.org/wiki/Polygon_mesh#Winged-edge_meshes
*********************************/

class WingedEdgeMesh {
  // Golden Ratio
  private float phi;
  
  // Size of edges in the figure
  private float c;
  
  //Vertex List
  private ArrayList<Vertex> vertexList;
  
  //Faces HashMap
  private HashMap<String, Face> faceMap;
  
  //Edges HashMap
  private HashMap<String, Edge> edgeMap;
  
  PShape retainedModel;
  
  WingedEdgeMesh(){
    phi = 1.61803398874;
    c = 50.0;
    
    vertexList = new ArrayList<Vertex>();
    faceMap    = new HashMap< String, Face >();
    edgeMap    = new HashMap< String, Edge >();
  
    //Vertices
    // 1 - (      0,     -c,  phi*c )  -  e1,  e3,  e5, e17, e15
    // 2 - (      c, -phi*c,      0 )  -  e2,  e1, e13, e11, e10
    // 3 - (     -c, -phi*c,      0 )  -  e2,  e8,  e6,  e4,  e3
    // 4 - ( -phi*c,      0,      c )  -  e4,  e7, e25, e16,  e5
    // 5 - ( -phi*c,      0,     -c )  -  e9, e19, e26,  e7,  e6
    // 6 - (      0,     -c, -phi*c )  - e10, e12, e18,  e9,  e8
    // 7 - (  phi*c,      0,     -c )  - e11, e14, e29, e20, e12
    // 8 - (  phi*c,      0,      c )  - e15, e21, e30, e14, e13
    // 9 - (      0,      c,  phi*c )  - e17, e16, e22, e24, e21
    // 10 -(      0,      c, -phi*c )   - e18, e20, e28, e27, e19
    // 11 -(     -c,  phi*c,      0 )   - e26, e27, e23, e22, e25
    // 12 -(      c,  phi*c,      0 )   - e30, e24, e23, e28, e29
    
    String[][] arrAux = new String[][]{
      {  "e1",  "e3",  "e5", "e17", "e15" },  //1
      {  "e2",  "e1", "e13", "e11", "e10" },  //2
      {  "e2",  "e8",  "e6",  "e4",  "e3" },  //3
      {  "e4",  "e7", "e25", "e16",  "e5" },  //4
      {  "e9", "e19", "e26",  "e7",  "e6" },  //5
      { "e10", "e12", "e18",  "e9",  "e8" },  //6
      { "e11", "e14", "e29", "e20", "e12" },  //7
      { "e15", "e21", "e30", "e14", "e13" },  //8
      { "e17", "e16", "e22", "e24", "e21" },  //9
      { "e18", "e20", "e28", "e27", "e19" },  //10
      { "e26", "e27", "e23", "e22", "e25" },  //11
      { "e30", "e24", "e23", "e28", "e29" }   //12
    };
    
    vertexList.add(null); // 0-index none
    vertexList.add( new Vertex(      0,     -c,  phi*c,  arrAux[0] ) ); //1
    vertexList.add( new Vertex(      c, -phi*c,      0,  arrAux[1] ) ); //2
    vertexList.add( new Vertex(     -c, -phi*c,      0,  arrAux[2] ) ); //3
    vertexList.add( new Vertex( -phi*c,      0,      c,  arrAux[3] ) ); //4
    vertexList.add( new Vertex( -phi*c,      0,     -c,  arrAux[4] ) ); //5
    vertexList.add( new Vertex(      0,     -c, -phi*c,  arrAux[5] ) ); //6
    vertexList.add( new Vertex(  phi*c,      0,     -c,  arrAux[6] ) ); //7
    vertexList.add( new Vertex(  phi*c,      0,      c,  arrAux[7] ) ); //8
    vertexList.add( new Vertex(      0,      c,  phi*c,  arrAux[8] ) ); //9
    vertexList.add( new Vertex(      0,      c, -phi*c,  arrAux[9] ) ); //10
    vertexList.add( new Vertex(     -c,  phi*c,      0, arrAux[10] ) ); //11
    vertexList.add( new Vertex(      c,  phi*c,      0, arrAux[11] ) ); //12
    
    //Faces
    //A -  e1,  e2,  e3
    //B -  e5,  e3,  e4
    //C -  e4,  e6,  e7
    //D -  e6,  e8,  e9
    //E -  e8,  e2, e10
    //F - e10, e11, e12
    //G - e11, e13, e14
    //H - e13,  e1, e15
    //I - e17,  e5, e16
    //J -  e9, e18, e19
    //K - e18, e12, e20
    //L - e15, e17, e21
    //M - e24, e22, e23
    //N - e16, e25, e22
    //O - e25,  e7, e26
    //P - e26, e19, e27
    //Q - e27, e28, e23
    //R - e20, e29, e28
    //S - e29, e14, e30
    //T - e30, e21, e24
    
    String[][] arrAuxFaces = new String[][]{
      {  "e1",  "e2",  "e3" }, //A
      {  "e5",  "e3",  "e4" }, //B
      {  "e4",  "e6",  "e7" }, //C
      {  "e6",  "e8",  "e9" }, //D
      {  "e8",  "e2", "e10" }, //E
      { "e10", "e11", "e12" }, //F
      { "e11", "e13", "e14" }, //G
      { "e13",  "e1", "e15" }, //H
      { "e17",  "e5", "e16" }, //I
      {  "e9", "e18", "e19" }, //J
      { "e18", "e12", "e20" }, //K
      { "e15", "e17", "e21" }, //L
      { "e24", "e22", "e23" }, //M
      { "e16", "e25", "e22" }, //N
      { "e25",  "e7", "e26" }, //O
      { "e26", "e19", "e27" }, //P
      { "e27", "e28", "e23" }, //Q
      { "e20", "e29", "e28" }, //R
      { "e29", "e14", "e30" }, //S
      { "e30", "e21", "e24" }  //T
    };
    
    faceMap.put( "A", new Face (  arrAuxFaces[0] ) );
    faceMap.put( "B", new Face (  arrAuxFaces[1] ) );
    faceMap.put( "C", new Face (  arrAuxFaces[2] ) );
    faceMap.put( "D", new Face (  arrAuxFaces[3] ) );
    faceMap.put( "E", new Face (  arrAuxFaces[4] ) );
    faceMap.put( "F", new Face (  arrAuxFaces[5] ) );
    faceMap.put( "G", new Face (  arrAuxFaces[6] ) );
    faceMap.put( "H", new Face (  arrAuxFaces[7] ) );
    faceMap.put( "I", new Face (  arrAuxFaces[8] ) );
    faceMap.put( "J", new Face (  arrAuxFaces[9] ) );
    faceMap.put( "K", new Face ( arrAuxFaces[10] ) );
    faceMap.put( "L", new Face ( arrAuxFaces[11] ) );
    faceMap.put( "M", new Face ( arrAuxFaces[12] ) );
    faceMap.put( "N", new Face ( arrAuxFaces[13] ) );
    faceMap.put( "O", new Face ( arrAuxFaces[14] ) );
    faceMap.put( "P", new Face ( arrAuxFaces[15] ) );
    faceMap.put( "Q", new Face ( arrAuxFaces[16] ) );
    faceMap.put( "R", new Face ( arrAuxFaces[17] ) );
    faceMap.put( "S", new Face ( arrAuxFaces[18] ) );
    faceMap.put( "T", new Face ( arrAuxFaces[19] ) );
    
    //Edges
    //e1  - 1, 2   - H, A - e3, e5, e2, e12 
    //e2  - 2, 3   - E, A - e1, e9, e3, e7
    //e3  - 1, 3   - A, B - e5, e1, e4, e2
    //e4  - 3, 4   - B, C - e3, e6, e5, e7
    //e5  - 1, 4   - I, B - e16, e3, e15, e4
    //e6  - 3, 5   - C, D - e4, e8, e7, e9
    //e7  - 4, 5   - C, O - e25, e4, e26, e6
    //e8  - 3, 6   - D, E - e6, e2, e9, e10
    //e9  - 5, 6   - D, J - e19, e6, e18, e8
    //e10 - 2, 6   - E, F - e2, e11, e8, e12
    //e11 - 2, 7   - F, G - e10, e13, e12, e14
    //e12 - 6, 7   - K, F - e18, e10, e20, e11
    //e13 - 2, 8   - G, H - e11, e1, e14, e15
    //e14 - 7, 8   - G, S - e29, e11, e30, e13
    //e15 - 1, 8   - H, L - e1, e17, e13, e21
    //e16 - 4, 9   - I, N - e5, e25, e17, e22
    //e17 - 1, 9   - L, I - e15, e5, e21, e16
    //e18 - 6, 10  - J, K - e9, e12, e19, e20
    //e19 - 5, 10  - P, J - e26, e9, e27, e18
    //e20 - 7, 10  - R, K - e12, e29, e18, e28
    //e21 - 8, 9   - T, L - e30, e15, e24, e17
    //e22 - 9, 11  - M, N - e24, e16, e23, e25
    //e23 - 11, 12 - M, Q - e22, e27, e24, e28
    //e24 - 9, 12  - M, T - e23, e30, e22, e21
    //e25 - 4, 11  - N, O - e16, e7, e22, e26
    //e26 - 5, 11  - O, P - e7, e19, e25, e27
    //e27 - 10, 11 - P, Q - e19, e28, e26, e23
    //e28 - 10, 12 - Q, R - e27, e20, e23, e29
    //e29 - 7, 12  - R, S - e20, e14, e28, e30
    //e30 - 8, 12  - S, T - e14, e21, e29, e24
    
    Integer[][] arrAuxVertices = new Integer[][]{
      {  1,  2 }, //e1
      {  2,  3 }, //e2
      {  1,  3 }, //e3
      {  3,  4 }, //e4
      {  1,  4 }, //e5
      {  3,  5 }, //e6
      {  4,  5 }, //e7
      {  3,  6 }, //e8
      {  5,  6 }, //e9
      {  2,  6 }, //e10
      {  2,  7 }, //e11
      {  6,  7 }, //e12
      {  2,  8 }, //e13
      {  7,  8 }, //e14
      {  1,  8 }, //e15
      {  4,  9 }, //e16
      {  1,  9 }, //e17
      {  6, 10 }, //e18
      {  5, 10 }, //e19
      {  7, 10 }, //e20
      {  8,  9 }, //e21
      {  9, 11 }, //e22
      { 11, 12 }, //e23
      {  9, 12 }, //e24
      {  4, 11 }, //e25
      {  5, 11 }, //e26
      { 10, 11 }, //e27
      { 10, 12 }, //e28
      {  7, 12 }, //e29
      {  8, 12 }  //e30
    };
    
    String[][] arrAuxFaces2 = new String[][]{
      { "H", "A" }, //e1
      { "E", "A" }, //e2
      { "A", "B" }, //e3
      { "B", "C" }, //e4
      { "I", "B" }, //e5
      { "C", "D" }, //e6
      { "C", "O" }, //e7
      { "D", "E" }, //e8
      { "D", "J" }, //e9
      { "E", "F" }, //e10
      { "F", "G" }, //e11
      { "K", "F" }, //e12
      { "G", "H" }, //e13
      { "G", "S" }, //e14
      { "H", "L" }, //e15
      { "I", "N" }, //e16
      { "L", "I" }, //e17
      { "J", "K" }, //e18
      { "P", "J" }, //e19
      { "R", "K" }, //e20
      { "T", "L" }, //e21
      { "M", "N" }, //e22
      { "M", "Q" }, //e23
      { "M", "T" }, //e24
      { "N", "O" }, //e25
      { "O", "P" }, //e26
      { "P", "Q" }, //e27
      { "Q", "R" }, //e28
      { "R", "S" }, //e29
      { "S", "T" }  //e30
    };
    
    String[][] arrAuxEdges = new String[][]{
      {  "e3",  "e5",  "e2", "e12" }, //e1
      {  "e1",  "e9",  "e3",  "e7" }, //e2
      {  "e5",  "e1",  "e4",  "e2" }, //e3
      {  "e3",  "e6",  "e5",  "e7" }, //e4
      { "e16",  "e3", "e15",  "e4" }, //e5
      {  "e4",  "e8",  "e7",  "e9" }, //e6
      { "e25",  "e4", "e26",  "e6" }, //e7
      {  "e6",  "e2",  "e9", "e10" }, //e8
      { "e19",  "e6", "e18",  "e8" }, //e9
      {  "e2", "e11",  "e8", "e12" }, //e10
      { "e10", "e13", "e12", "e14" }, //e11
      { "e18", "e10", "e20", "e11" }, //e12
      { "e11",  "e1", "e14", "e15" }, //e13
      { "e29", "e11", "e30", "e13" }, //e14
      {  "e1", "e17", "e13", "e21" }, //e15
      {  "e5", "e25", "e17", "e22" }, //e16
      { "e15",  "e5", "e21", "e16" }, //e17
      {  "e9", "e12", "e19", "e20" }, //e18
      { "e26",  "e9", "e27", "e18" }, //e19
      { "e12", "e29", "e18", "e28" }, //e20
      { "e30", "e15", "e24", "e17" }, //e21
      { "e24", "e16", "e23", "e25" }, //e22
      { "e22", "e27", "e24", "e28" }, //e23
      { "e23", "e30", "e22", "e21" }, //e24
      { "e16",  "e7", "e22", "e26" }, //e25
      {  "e7", "e19", "e25", "e27" }, //e26
      { "e19", "e28", "e26", "e23" }, //e27
      { "e27", "e20", "e23", "e29" }, //e28
      { "e20", "e14", "e28", "e30" }, //e29
      { "e14", "e21", "e29", "e24" }  //e30
    };
    
    edgeMap.put(  "e1", new Edge(  arrAuxVertices[0],  arrAuxFaces2[0],  arrAuxEdges[0] ) );
    edgeMap.put(  "e2", new Edge(  arrAuxVertices[1],  arrAuxFaces2[1],  arrAuxEdges[1] ) );
    edgeMap.put(  "e3", new Edge(  arrAuxVertices[2],  arrAuxFaces2[2],  arrAuxEdges[2] ) );
    edgeMap.put(  "e4", new Edge(  arrAuxVertices[3],  arrAuxFaces2[3],  arrAuxEdges[3] ) );
    edgeMap.put(  "e5", new Edge(  arrAuxVertices[4],  arrAuxFaces2[4],  arrAuxEdges[4] ) );
    edgeMap.put(  "e6", new Edge(  arrAuxVertices[5],  arrAuxFaces2[5],  arrAuxEdges[5] ) );
    edgeMap.put(  "e7", new Edge(  arrAuxVertices[6],  arrAuxFaces2[6],  arrAuxEdges[6] ) );
    edgeMap.put(  "e8", new Edge(  arrAuxVertices[7],  arrAuxFaces2[7],  arrAuxEdges[7] ) );
    edgeMap.put(  "e9", new Edge(  arrAuxVertices[8],  arrAuxFaces2[8],  arrAuxEdges[8] ) );
    edgeMap.put( "e10", new Edge(  arrAuxVertices[9],  arrAuxFaces2[9],  arrAuxEdges[9] ) );
    edgeMap.put( "e11", new Edge( arrAuxVertices[10], arrAuxFaces2[10], arrAuxEdges[10] ) );
    edgeMap.put( "e12", new Edge( arrAuxVertices[11], arrAuxFaces2[11], arrAuxEdges[11] ) );
    edgeMap.put( "e13", new Edge( arrAuxVertices[12], arrAuxFaces2[12], arrAuxEdges[12] ) );
    edgeMap.put( "e14", new Edge( arrAuxVertices[13], arrAuxFaces2[13], arrAuxEdges[13] ) );
    edgeMap.put( "e15", new Edge( arrAuxVertices[14], arrAuxFaces2[14], arrAuxEdges[14] ) );
    edgeMap.put( "e16", new Edge( arrAuxVertices[15], arrAuxFaces2[15], arrAuxEdges[15] ) );
    edgeMap.put( "e17", new Edge( arrAuxVertices[16], arrAuxFaces2[16], arrAuxEdges[16] ) );
    edgeMap.put( "e18", new Edge( arrAuxVertices[17], arrAuxFaces2[17], arrAuxEdges[17] ) );
    edgeMap.put( "e19", new Edge( arrAuxVertices[18], arrAuxFaces2[18], arrAuxEdges[18] ) );
    edgeMap.put( "e20", new Edge( arrAuxVertices[19], arrAuxFaces2[19], arrAuxEdges[19] ) );
    edgeMap.put( "e21", new Edge( arrAuxVertices[20], arrAuxFaces2[20], arrAuxEdges[20] ) );
    edgeMap.put( "e22", new Edge( arrAuxVertices[21], arrAuxFaces2[21], arrAuxEdges[21] ) );
    edgeMap.put( "e23", new Edge( arrAuxVertices[22], arrAuxFaces2[22], arrAuxEdges[22] ) );
    edgeMap.put( "e24", new Edge( arrAuxVertices[23], arrAuxFaces2[23], arrAuxEdges[23] ) );
    edgeMap.put( "e25", new Edge( arrAuxVertices[24], arrAuxFaces2[24], arrAuxEdges[24] ) );
    edgeMap.put( "e26", new Edge( arrAuxVertices[25], arrAuxFaces2[25], arrAuxEdges[25] ) );
    edgeMap.put( "e27", new Edge( arrAuxVertices[26], arrAuxFaces2[26], arrAuxEdges[26] ) );
    edgeMap.put( "e28", new Edge( arrAuxVertices[27], arrAuxFaces2[27], arrAuxEdges[27] ) );
    edgeMap.put( "e29", new Edge( arrAuxVertices[28], arrAuxFaces2[28], arrAuxEdges[28] ) );
    edgeMap.put( "e30", new Edge( arrAuxVertices[29], arrAuxFaces2[29], arrAuxEdges[29] ) );
    
    
    retainedModel = createShape();
    retainedModel.beginShape(TRIANGLE);
    retainedModel.noFill();
    retainedModel.stroke(0, 0, 255);
    retainedModel.strokeWeight(3);
    Face face;
    Edge edge1, edge2, edge3;
    Vertex vertex;
    for (HashMap.Entry<String, Face> entry : faceMap.entrySet()) {
      face = entry.getValue();
      edge1 = edgeMap.get( face.edges[0] ); edge2 = edgeMap.get( face.edges[1] ); edge3 = edgeMap.get( face.edges[2] );
      
      vertex = vertexList.get(edge1.vertices[0]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
      
      vertex = vertexList.get(edge1.vertices[1]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
      
      vertex = vertexList.get(edge2.vertices[0]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
      
      vertex = vertexList.get(edge2.vertices[1]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
      
      vertex = vertexList.get(edge3.vertices[0]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
      
      vertex = vertexList.get(edge3.vertices[1]);
      retainedModel.vertex( vertex.x, vertex.y, vertex.z );
    }
    
    retainedModel.endShape();
  }
  
  void draw( boolean retained ){
    if( retained ){
      shape(retainedModel);
    }else{
      Face face;
      Edge edge1, edge2, edge3;
      Vertex vertex;
      noFill();
      stroke(255, 0, 0);
      strokeWeight(3);
      beginShape(TRIANGLE);
      for (HashMap.Entry<String, Face> entry : faceMap.entrySet()) {
        face = entry.getValue();
        edge1 = edgeMap.get( face.edges[0] ); edge2 = edgeMap.get( face.edges[1] ); edge3 = edgeMap.get( face.edges[2] );
        
        vertex = vertexList.get(edge1.vertices[0]);
        vertex( vertex.x, vertex.y, vertex.z );
        
        vertex = vertexList.get(edge1.vertices[1]);
        vertex( vertex.x, vertex.y, vertex.z );
        
        vertex = vertexList.get(edge2.vertices[0]);
        vertex( vertex.x, vertex.y, vertex.z );
        
        vertex = vertexList.get(edge2.vertices[1]);
        vertex( vertex.x, vertex.y, vertex.z );
        
        vertex = vertexList.get(edge3.vertices[0]);
        vertex( vertex.x, vertex.y, vertex.z );
        
        vertex = vertexList.get(edge3.vertices[1]);
        vertex( vertex.x, vertex.y, vertex.z );
      }
     
      endShape();
    }
  }
}

class Vertex{
  public float x;
  public float y;
  public float z;
  
  public String edges[];
  
  Vertex( float x, float y, float z, String[] e ){
    this.x = x;
    this.y = y;
    this.z = z;
    this.edges = e;
  }
}

class Face{
  public String edges[];
  
  Face( String[] e ){    
    this.edges = e;
  }
}

class Edge{
  public Integer vertices[];
  public String faces[];
  public String neighborEdges[];
  
  Edge( Integer[] v, String[] f, String[] nE ){
    this.vertices = v;
    this.faces = f;
    this.neighborEdges = nE;
  }
}