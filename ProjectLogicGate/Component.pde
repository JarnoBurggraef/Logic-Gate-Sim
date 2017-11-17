ArrayList<Component> allComponents = new ArrayList<Component>();
class Component {
  int x, y, xsize, ysize;
  
  boolean isMoving = false;
  
  Component[] inputComponents;
  boolean[] inputs;
  int inputSize;
  
  
  Component[] outputComponents;
  int[] outputComponentsIndices;
  boolean[] outputs;
  int outputSize;
  
  Component(int _x, int _y){
    x = _x;
    y = _y;
  }
  Component(){
    x = width/2;
    y = height/2;
  }
  
  void Paint(){
    
  }
  
  void Work(){
    
  }
  
  void setupIO(){
    inputComponents = new Component[inputSize];
    inputs = new boolean[inputSize];
    outputComponents = new Component[outputSize];
    outputs = new boolean[outputSize];  
    outputComponentsIndices = new int[outputSize];
  }
  
}