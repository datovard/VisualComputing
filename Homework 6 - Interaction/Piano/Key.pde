abstract class Key {
  float width, height, depth;
  float x, y, z, frequency;
  boolean press;
  
  Key ( float w, float h, float d, float x, float y, float z, float freq ) {
    this.width = w;
    this.height = h;
    this.depth = d;
    
    this.x = x;
    this.y = y;
    this.z = z;
    
    this.frequency = freq;
    this.press = false;
  }
  
  abstract void draw();
  
  abstract void sound();
  
  void pressKey(){
    this.press = true;
  }
  
  void unpressKey(){
    this.press = false;
  }
}