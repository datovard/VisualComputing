import remixlab.proscene.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Scene scene;

String renderer = P3D;

HashMap< Character, Integer > noteMap;

Octave oct1, oct2, oct3, oct4;

Minim       minim;
AudioOutput out;
Oscil       wave;

Integer octaveSelected, keySelected;

void setup() {
  size(800, 650, renderer);
  //Scene instantiation
  scene = new Scene(this);
  noteMap = new HashMap<Character, Integer>();
  
  // when damping friction = 0 -> spin
  scene.eyeFrame().setDamping(0);
  
  scene.disableKeyboardAgent();
  scene.disableMouseAgent();
  scene.toggleAxesVisualHint();
  scene.toggleGridVisualHint();
  
  //println("spinning sens: " +  scene.eyeFrame().spinningSensitivity());
  oct1 = new Octave( -60, -90, 0, 1, 2 );
  oct2 = new Octave( -60, -30, 0, 2, 3 );
  oct3 = new Octave( -60, 30, 0, 3, 4 );
  oct4 = new Octave( -60, 90, 0, 4, 5 );
  
  minim = new Minim(this);
 
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  octaveSelected = keySelected = null;
  
  noteMap.put('1', 0);
  noteMap.put('q', 0);
  noteMap.put('a', 0);
  noteMap.put('<', 0);
  noteMap.put('2', 1);
  noteMap.put('w', 1);
  noteMap.put('s', 1);
  noteMap.put('z', 1);
  noteMap.put('3', 2);
  noteMap.put('e', 2);
  noteMap.put('d', 2);
  noteMap.put('x', 2);
  noteMap.put('4', 3);
  noteMap.put('r', 3);
  noteMap.put('f', 3);
  noteMap.put('c', 3);
  noteMap.put('5', 4);
  noteMap.put('t', 4);
  noteMap.put('g', 4);
  noteMap.put('v', 4);
  noteMap.put('6', 5);
  noteMap.put('y', 5);
  noteMap.put('h', 5);
  noteMap.put('b', 5);
  noteMap.put('7', 6);
  noteMap.put('u', 6);
  noteMap.put('j', 6);
  noteMap.put('n', 6);
  noteMap.put('8', 7);
  noteMap.put('i', 7);
  noteMap.put('k', 7);
  noteMap.put('m', 7);
  noteMap.put('9', 8);
  noteMap.put('o', 8);
  noteMap.put('l', 8);
  noteMap.put(',', 8);
  noteMap.put('0', 9);
  noteMap.put('p', 9);
  noteMap.put('ñ', 9);
  noteMap.put('.', 9);
  noteMap.put('\'', 10);
  noteMap.put('´', 10);
  noteMap.put('{', 10);
  noteMap.put('-', 10);
  noteMap.put('¿', 11);
  noteMap.put('+', 11);
  noteMap.put('}', 11);
}

void draw() {
  background(0);
  fill(204, 102, 0, 150);

  oct1.draw();
  oct2.draw();
  oct3.draw();
  oct4.draw();
}

void deselectKeyPressed(){
  if( octaveSelected != null && keySelected != null){
    switch( octaveSelected ){
      case 1:
        oct1.deselectKey( keySelected );
        break;
      case 2:
        oct2.deselectKey( keySelected );
        break;
      case 3:
        oct3.deselectKey( keySelected );
        break;
      case 4:
        oct4.deselectKey( keySelected );
        break;
    }
  }
}

void keyPressed() {
  deselectKeyPressed();
  if ( key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '\'' || key == '¿' ){
    octaveSelected = 1; 
    oct1.sound( noteMap.get(key) );
  }
  if ( key == 'q' || key == 'w' || key == 'e' || key == 'r' || key == 't' || key == 'y' || key == 'u' || key == 'i' || key == 'o' || key == 'p' || key == '´' || key == '+' ){
    octaveSelected = 2;
    oct2.sound( noteMap.get(key) );
  }
  if ( key == 'a' || key == 's' || key == 'd' || key == 'f' || key == 'g' || key == 'h' || key == 'j' || key == 'k' || key == 'l' || key == 'ñ' || key == '{' || key == '}' ){
    octaveSelected = 3;
    oct3.sound( noteMap.get(key) );
  }
  if ( key == '<' || key == 'z' || key == 'x' || key == 'c' || key == 'v' || key == 'b' || key == 'n' || key == 'm' || key == ',' || key == '.' || key == '-' ){
    octaveSelected = 4;
    oct4.sound( noteMap.get(key) );
  }
  if ( key ==' '){
    if (wave != null && out != null )
      wave.unpatch(out);
    octaveSelected = keySelected = null;
  }
  keySelected = noteMap.get(key);
  if(scene.eyeFrame().damping() == 0)
    scene.eyeFrame().setDamping(0.5);
  else
    scene.eyeFrame().setDamping(0);
}