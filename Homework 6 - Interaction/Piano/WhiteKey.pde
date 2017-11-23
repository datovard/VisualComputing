class WhiteKey extends Key {
  String note; 
  PShape unpressed, pressed;
  
  WhiteKey( float x, float y, float z, String note, float freq ) {
    super( 20, 50, 10, x, y, z, freq );
    this.note = note;
  
    this.unpressed = createShape();
    this.unpressed.beginShape(QUADS);
    this.unpressed.fill(255);
    this.unpressed.stroke(0);
    this.unpressed.translate( this.x, this.y, this.z );
    this.unpressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), (this.height/2), -(this.depth/2));
    this.unpressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2));
    this.unpressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), (this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2) );
    this.unpressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.unpressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.unpressed.vertex((this.width/2), (this.height/2), -(this.depth/2) );
    this.unpressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.unpressed.endShape();
    
    this.pressed = createShape();
    this.pressed.beginShape(QUADS);
    this.pressed.fill(255, 240, 98);
    this.pressed.stroke(0);
    this.pressed.translate( this.x, this.y, this.z );
    this.pressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), (this.height/2), -(this.depth/2));
    this.pressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2));
    this.pressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), (this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex(-(this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex(-(this.width/2), (this.height/2), -(this.depth/2) );
    this.pressed.vertex(-(this.width/2), (this.height/2), (this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), (this.depth/2));
    this.pressed.vertex((this.width/2), -(this.height/2), -(this.depth/2));
    this.pressed.vertex((this.width/2), (this.height/2), -(this.depth/2) );
    this.pressed.vertex((this.width/2), (this.height/2), (this.depth/2));
    this.pressed.rotateX(-PI/18);
    this.pressed.endShape();
  }
  
  void draw (){
    pushMatrix();
    if( !this.press )
      shape( this.unpressed );
    else
      shape( this.pressed );      
    popMatrix();
    
    pushMatrix();
    fill(0);
    textSize(10);
    translate( this.x, this.y, this.z );
    text( note, -8, 15, 6 );
    popMatrix();
  }
}