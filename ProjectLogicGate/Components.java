import java.io.Serializable;
import static processing.core.PApplet.*;
class AndGate extends Component implements Serializable {
  public AndGate(){
    this(0,0);
  }
  AndGate(int _x, int _y){
    super(_x, _y);
    
    xsize = 100;
    ysize = 120;
    
    inputSize = 2;
    outputSize = 1;
    
    setupIO();
  }
  void Paint(){
    DrawStandardStuff();
    sketch.fill(0);
    sketch.text("&", x+40, y+70);
  }
  void Work(){
    outputs[0] = inputs[0] && inputs[1];
    TransmitOutput();
  }
}

class OrGate extends Component  implements Serializable{
  OrGate(){
    this(0,0);
  }
  OrGate(int _x, int _y){
    super(_x, _y);
    
    xsize = 100;
    ysize = 120;
    
    inputSize = 2;
    outputSize = 1;
    setupIO();
  }
  
  void Paint(){
    DrawStandardStuff();
    sketch.fill(0);
    sketch.text(">=1", x+15, y+70);
  }
  
  void Work(){
    outputs[0] = inputs[0] || inputs[1];
    TransmitOutput();
  }
}

class NotGate extends Component implements Serializable {
  NotGate(){
    this(0,0);
  }
  NotGate(int _x, int _y){
    super(_x, _y);
    
    xsize = 100;
    ysize = 30;
    
    inputSize = 1;
    outputSize = 1;
    setupIO();
  }
  
  void Paint(){
    DrawStandardStuff();
    sketch.fill(0);
    sketch.text("!",x+45,y+25);
  }
  
  void Work(){
    outputs[0] = !inputs[0];
    TransmitOutput();
  }
}

class Schalter extends Component implements Serializable {
  Schalter(){
    this(0,0);
  }
  Schalter(int _x,int _y){
    super(_x,_y);
    
    xsize=100;
    ysize=30;
     
    inputSize = 1;
    outputSize = 1;
    setupIO();
    
  }
  void Paint(){
    DrawStandardStuff();
    if (inputs[0])sketch.fill(0, 255, 0);
    else sketch.fill(255, 0, 0);
    sketch.rect(x+5, y+5, 40, 20);
  }
  void Work(){
    outputs[0] = inputs[0];
    TransmitOutput();
  }
}

class Lampe extends Component implements Serializable {
  Lampe(){
    this(0,0);
  }
  Lampe(int _x,int _y){
    super(_x,_y);
    
    xsize=85;
    ysize=60;
      
    inputSize = 1;
    outputSize = 1;
    setupIO();
    
  }
  void Paint(){
    DrawStandardStuff();
    if (outputs[0])sketch.fill(0, 255, 0);
    else sketch.fill(255, 0, 0);
    sketch.rect(x+30, y+5, 50, 50);
    sketch.fill(255);
  }
  void Work(){
    outputs[0] = inputs[0];
  }
}
class Splitter extends Component implements Serializable {
  Splitter(){
    this(0,0);
  }
  Splitter(int _x, int _y){
    super(_x,_y);
    xsize= 85;
    ysize = 90;
    
    inputSize = 1;
    outputSize = 2;
    setupIO();
  }
  void Paint(){
    DrawStandardStuff();
  }
  void Work(){
    outputs[0] = inputs[0];
    outputs[1] = inputs[0];
    TransmitOutput();
  }
}