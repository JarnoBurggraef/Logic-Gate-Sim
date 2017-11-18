class AndGate extends Component {
  public AndGate(){
    this(width/2,height/2);
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
    fill(0);
    text("&", x+40, y+70);
  }
  void Work(){
    outputs[0] = inputs[0] && inputs[1];
    TransmitOutput();
  }
}

class OrGate extends Component {
  OrGate(){
    this(width/2,height/2);
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
    fill(0);
    text(">=1", x+15, y+70);
  }
  
  void Work(){
    outputs[0] = inputs[0] || inputs[1];
    TransmitOutput();
  }
}

class NotGate extends Component {
  NotGate(){
    this(width/2,height/2);
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
    fill(0);
    text("!",x+45,y+25);
  }
  
  void Work(){
    outputs[0] = !inputs[0];
    TransmitOutput();
  }
}

class Schalter extends Component {
  Schalter(){
    this(width/2,height/2);
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
    if (inputs[0])fill(0, 255, 0);
    else fill(255, 0, 0);
    rect(x+5, y+5, 40, 20);
  }
  void Work(){
    outputs[0] = inputs[0];
    TransmitOutput();
  }
}

class Lampe extends Component {
  Lampe(){
    this(width/2,height/2);
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
    if (outputs[0])fill(0, 255, 0);
    else fill(255, 0, 0);
    rect(x+30, y+5, 50, 50);
    fill(255);
  }
  void Work(){
    outputs[0] = inputs[0];
  }
}
class Splitter extends Component {
  Splitter(){
    this(width/2,height/2);
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