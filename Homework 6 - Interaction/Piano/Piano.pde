import remixlab.proscene.*;
//import remixlab.dandelion.*;
import remixlab.dandelion.geom.Rect;
import remixlab.dandelion.core.GenericFrame;
import remixlab.dandelion.geom.Vec;
import remixlab.bias.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

Scene scene;

String renderer = P3D;

HashMap< Character, Integer > noteMap;
HashMap< Character, Boolean > keysPressed;

Octave oct1, oct2, oct3, oct4;

Minim       minim;
AudioOutput out;
Oscil       wave;

Integer octaveSelected, keySelected;

GenericFrame[] gfs;

boolean zoomed;

void setup() {
  size(1000, 700, renderer);
  //Scene instantiation
  scene = new Scene(this);
  scene.loadConfig();
  unregisterMethod("dispose", scene);
  noteMap = new HashMap<Character, Integer>();
  keysPressed =new HashMap<Character, Boolean>();
  
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
  
  keysPressed.put('1', false);
  keysPressed.put('q', false);
  keysPressed.put('a', false);
  keysPressed.put('<', false);
  keysPressed.put('2', false);
  keysPressed.put('w', false);
  keysPressed.put('s', false);
  keysPressed.put('z', false);
  keysPressed.put('3', false);
  keysPressed.put('e', false);
  keysPressed.put('d', false);
  keysPressed.put('x', false);
  keysPressed.put('4', false);
  keysPressed.put('r', false);
  keysPressed.put('f', false);
  keysPressed.put('c', false);
  keysPressed.put('5', false);
  keysPressed.put('t', false);
  keysPressed.put('g', false);
  keysPressed.put('v', false);
  keysPressed.put('6', false);
  keysPressed.put('y', false);
  keysPressed.put('h', false);
  keysPressed.put('b', false);
  keysPressed.put('7', false);
  keysPressed.put('u', false);
  keysPressed.put('j', false);
  keysPressed.put('n', false);
  keysPressed.put('8', false);
  keysPressed.put('i', false);
  keysPressed.put('k', false);
  keysPressed.put('m', false);
  keysPressed.put('9', false);
  keysPressed.put('o', false);
  keysPressed.put('l', false);
  keysPressed.put(',', false);
  keysPressed.put('0', false);
  keysPressed.put('p', false);
  keysPressed.put('ñ', false);
  keysPressed.put('.', false);
  keysPressed.put('\'', false);
  keysPressed.put('´', false);
  keysPressed.put('{', false);
  keysPressed.put('-', false);
  keysPressed.put('¿', false);
  keysPressed.put('+', false);
  keysPressed.put('}', false);
  
  gfs = new GenericFrame[] { 
    new GenericFrame(scene, new Vec(-25, -90, 75)),
    new GenericFrame(scene, new Vec(-25, -35, 75)),
    new GenericFrame(scene, new Vec(-25, 20, 75)),
    new GenericFrame(scene, new Vec(-25, 75, 75)),
  };
  
  zoomed = false;
}

void draw() {
  background(0);
  
  oct1.draw();
  oct2.draw();
  oct3.draw();
  oct4.draw();
  
  Character key;
  for (HashMap.Entry<Character, Boolean> entry : keysPressed.entrySet())
  {
    if( entry.getValue() ){
      key = entry.getKey();
      if ( key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '\'' || key == '¿' ){
        oct1.sound( noteMap.get(key) );
        if( zoomed ) scene.eye().interpolateTo(gfs[0], 0.7);
      }
      if ( key == 'q' || key == 'w' || key == 'e' || key == 'r' || key == 't' || key == 'y' || key == 'u' || key == 'i' || key == 'o' || key == 'p' || key == '´' || key == '+' ){
        oct2.sound( noteMap.get(key) );
        if( zoomed ) scene.eye().interpolateTo(gfs[1], 0.7);
      }
      if ( key == 'a' || key == 's' || key == 'd' || key == 'f' || key == 'g' || key == 'h' || key == 'j' || key == 'k' || key == 'l' || key == 'ñ' || key == '{' || key == '}' ){
        oct3.sound( noteMap.get(key) );
        if( zoomed ) scene.eye().interpolateTo(gfs[2], 0.7);
      }
      if ( key == '<' || key == 'z' || key == 'x' || key == 'c' || key == 'v' || key == 'b' || key == 'n' || key == 'm' || key == ',' || key == '.' || key == '-' ){      
        oct4.sound( noteMap.get(key) );
        if( zoomed ) scene.eye().interpolateTo(gfs[3], 0.7);
      }
    }
  }
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
  if( key == '!' ){
    scene.eye().interpolateTo(gfs[0], 1.0);
    zoomed = true;
  }
  else if( key == '\"' ){
    scene.eye().interpolateTo(gfs[1], 1.0);
    zoomed = true;
  }
  else if( key == '#' ){
    scene.eye().interpolateTo(gfs[2], 1.0);
    zoomed = true;
  }
  else if( key == '$' ){
    scene.eye().interpolateTo(gfs[3], 1.0);
    zoomed = true;
  }
  else if( key == '=' ){
    scene.eye().interpolateToFitScene();
    zoomed = false;
  }
  else if ( key == ' '){
    if (wave != null && out != null )
      wave.unpatch(out);
    octaveSelected = keySelected = null;
  }
  else keysPressed.put( key, true );
  
  if(scene.eyeFrame().damping() == 0)
    scene.eyeFrame().setDamping(0.5);
  else
    scene.eyeFrame().setDamping(0);
}

void keyReleased(){
  keysPressed.put(key, false);
  if ( key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '\'' || key == '¿' ){
    oct1.deselectKey( noteMap.get( key ) );
  }
  if ( key == 'q' || key == 'w' || key == 'e' || key == 'r' || key == 't' || key == 'y' || key == 'u' || key == 'i' || key == 'o' || key == 'p' || key == '´' || key == '+' ){
    oct2.deselectKey( noteMap.get( key ) );
  }
  if ( key == 'a' || key == 's' || key == 'd' || key == 'f' || key == 'g' || key == 'h' || key == 'j' || key == 'k' || key == 'l' || key == 'ñ' || key == '{' || key == '}' ){
    oct3.deselectKey( noteMap.get( key ) );
  }
  if ( key == '<' || key == 'z' || key == 'x' || key == 'c' || key == 'v' || key == 'b' || key == 'n' || key == 'm' || key == ',' || key == '.' || key == '-' ){      
    oct4.deselectKey( noteMap.get( key ) );
  }
}