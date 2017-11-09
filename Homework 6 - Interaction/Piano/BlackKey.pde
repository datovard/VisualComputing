class BlackKey {
  float width, height, depth;
  float x, y, z;
  String note1, note2;
  
  BlackKey( float x, float y, float z, String note1, String note2 ) {
    this.width = 12;
    this.height = 25;
    this.depth = 20;
    this.x = x;
    this.y = y;
    this.z = z;
    this.note1 = note1;
    this.note2 = note2;
  }
  
  void draw (){
    pushMatrix();
    fill(0);
    stroke(255);
    translate( this.x, this.y, this.z );
    box( this.width, this.height, this.depth );
    
    pushMatrix();
    fill(255);
    textSize(5);
    text( note1, -5, -4, 11 );
    text( note2, -5, 7, 11 );
    popMatrix();
    
    popMatrix();
  }
}