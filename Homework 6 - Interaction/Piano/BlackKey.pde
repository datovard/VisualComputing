class BlackKey extends Key {
  String note1, note2;
  PShape unpressed, pressed;
  
  BlackKey( float x, float y, float z, String note1, String note2, float freq ) {
    super( 12, 25, 20, x, y, z, freq );
    
    this.note1 = note1;
    this.note2 = note2;
    
    this.unpressed = createShape();
    this.unpressed.beginShape(QUADS);
    this.unpressed.fill(0);
    this.unpressed.stroke(255);
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
    if( !this.press )
      fill(255);
    else
      fill(0);
    
    textSize(5);
    translate( this.x, this.y, this.z );
    text( note1, -5, -4, 11 );
    text( note2, -5, 7, 11 );
    popMatrix();
  }
  
  void sound(){
    this.pressKey();
    if ( wave != null && out != null )
      wave.unpatch(out);
    
    // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
    wave = new Oscil( this.frequency, (float)Math.log10( this.frequency ), Waves.SINE );
    
    // patch the Oscil to the output
    wave.patch( out );
  }
}