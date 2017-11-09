class Octave {
  float x, y, z;
  boolean keys[];
  String notes[];
  int n_octave;
  
  Octave ( float x, float y, float z, int n_octave ) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.n_octave = n_octave;
    keys = new boolean[] { false, true, false, true, false, false, true, false, true, false, true, false };
    notes = new String[] { "Do", "Do#", "Reb", "Re", "Re#", "Mib", "Mi", "Fa", "Fa#", "Solb", "Sol", "Sol#", "Lab", "La", "La#", "Sib", "Si" };
  }
  
  void draw() {
    int x_pos = 0, note_i = 0;
    pushMatrix();
    translate( this.x, this.y, this.z );
    for( int i = 0; i < 12; i++ ){
      if( i >= 1 && keys[i] == keys[i-1] ) x_pos += 10;
      if( this.keys[i] ){
        ( new BlackKey(x_pos, -12, 0, this.notes[note_i], this.notes[note_i+1]) ).draw(); 
        note_i+=2;
      }else{ 
        ( new WhiteKey(x_pos, 0, 0, this.notes[note_i] ) ).draw();
        note_i++;
      }
      x_pos += 10;
    }
    
    pushMatrix();
    fill(255);
    text("Octava "+this.n_octave, -70, 0, 0);
    popMatrix();
  
    popMatrix();
  }
}