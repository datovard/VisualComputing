class Octave {
  float x, y, z;
  boolean keyType[];
  String notes[];
  int n_octave;
  Key keys[];
  int frequency_index;
  
  Octave ( float x, float y, float z, int n_octave, int freq ) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.n_octave = n_octave;
    this.frequency_index = freq;
    keyType = new boolean[] { false, true, false, true, false, false, true, false, true, false, true, false };
    notes = new String[] { "Do", "Do#", "Reb", "Re", "Re#", "Mib", "Mi", "Fa", "Fa#", "Solb", "Sol", "Sol#", "Lab", "La", "La#", "Sib", "Si" };
    keys = new Key[12];  
    
    int x_pos = 0, note_i = 0;
    
    for( int i = 0; i < 12; i++ ){
      if( i >= 1 && keyType[i] == keyType[i-1] ) x_pos += 10;
      if( this.keyType[i] ){
        keys[i] = (Key)( new BlackKey(x_pos, -12, 0, this.notes[note_i], this.notes[note_i+1], FREQUENCIES[frequency_index][i]) );
        note_i+=2;
      }else{ 
        keys[i] = (Key)( new WhiteKey(x_pos, 0, 0, this.notes[note_i], FREQUENCIES[frequency_index][i] ) );
        note_i++;
      }
      x_pos += 10;
    }
  }
  
  void draw() {   
    pushMatrix();
    translate( this.x, this.y, this.z );
    for( int i = 0; i < 12; i++ )
      keys[i].draw();
 
    pushMatrix();
    fill(255);
    text("Octava "+this.n_octave, -70, 0, 0);
    popMatrix();
  
    popMatrix();
  }
  
  void sound( int key ){
    this.keys[key].sound();
  }
  
  void deselectKey( int keySelected ){
    this.keys[keySelected].unpressKey();
  }
}