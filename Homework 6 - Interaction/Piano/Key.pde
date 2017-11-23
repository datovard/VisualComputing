abstract class Key {//extends InteractiveFrame{
  float width, height, depth;
  float x, y, z, frequency;
  boolean press;
  
  Key ( float w, float h, float d, float x, float y, float z, float freq ) {
    //super( scene );
    this.width = w;
    this.height = h;
    this.depth = d;
    
    this.x = x;
    this.y = y;
    this.z = z;
    
    this.frequency = freq;
    this.press = false;
    
    //this.setClickBinding(LEFT, 1, "keyClick"); 
  }
  
  void keyClick( ClickEvent event ){
    System.out.println(this.frequency);
  }
  
  abstract void draw();
  
  void sound(){
    if( !this.press ){
      this.pressKey();
      out.playNote( this.frequency );
    }
  }
  
  void pressKey(){
    this.press = true;
  }
  
  void unpressKey(){
    this.press = false;
  }
}