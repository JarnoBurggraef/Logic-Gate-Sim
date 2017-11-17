class AndGate extends Component {
  AndGate(int _x, int _y){
    super(_x, _y);
    
    xsize = 100;
    ysize = 120;
    
    inputSize = 2;
    outputSize = 1;
    
    setupIO();
  }
  void Paint(){
    drawBackground();
    rect(x+xsize-25, y+ysize/2-10, 20, 20);
    rect(x+5, y+20, 20, 20);
    rect(x+5, y+80, 20, 20);
    fill(0);
    text("&", x+40, y+70);
  }
  void Work(){
    outputs[0] = inputs[0] && inputs[1];
    TransmitOutput();
  }
}

class OrGate extends Component {
  OrGate(int _x, int _y){
    super(_x, _y);
    
    xsize = 100;
    ysize = 120;
    
    inputSize = 2;
    outputSize = 1;
    setupIO();
  }
  
  void Paint(){
    rect(x+xsize-25, y+ysize/2-10, 20, 20);
    rect(x+5, y+20, 20, 20);
    rect(x+5, y+80, 20, 20);
    fill(0);
    text(">=1", x+10, y+70);
  }
  
  void Work(){
    outputs[0] = inputs[0] || inputs[1];
    TransmitOutput();
  }
}

class NotGate extends Component {
  NotGate(int _x, int _y){
    super(_x, _y);
    inputSize = 1;
    outputSize = 1;
    setupIO();
  }
  
  void Paint(){
  
  }
  
  void Work(){
    outputs[0] = !inputs[0];
    TransmitOutput();
  }
}

class Schalter extends Component {
  
  Schalter(int _x,int _y){
    super(_x,_y);
    
    xsize=100;
    ysize=30;
     
    inputSize = 1;
    outputSize = 1;
    setupIO();
    
  }
  void Paint(){
    
  }
  void Work(){
    outputs[0] = inputs[0];
    TransmitOutput();
  }
}

class Lampe extends Component {
  
  Lampe(int _x,int _y){
    super(_x,_y);
    
    xsize=85;
    ysize=60;
      
    inputSize = 1;
    outputSize = 1;
    setupIO();
    
  }
  void Paint(){
    
  }
  void Work(){
    outputs[0] = inputs[0];
  }
}