class WhiteKey {
  float width, height, depth;
  float x, y, z;
  String note;
  
  WhiteKey( float x, float y, float z, String note ) {
    this.width = 20;
    this.height = 50;
    this.depth = 10;
    this.x = x;
    this.y = y;
    this.z = z;
    this.note = note;
  }
  
  void draw (){
    pushMatrix();
    fill(255);
    stroke(0);
    translate( this.x, this.y, this.z );
    box( this.width, this.height, this.depth );
    
    pushMatrix();
    fill(0);
    textSize(10);
    text( note, -8, 15, 6 );
    popMatrix();
    
    popMatrix();
  }
}