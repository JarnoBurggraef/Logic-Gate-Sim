ArrayList<Component> allComponents = new ArrayList<Component>();
abstract class Component {
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
  
  color getEdgeColor(){
    return isMoving ? color(255,0,0) : color(0);
  }
  void drawBackground(){
    fill(255);
    stroke(getEdgeColor());
    rect(x,y,xsize,ysize);
  }
  
  abstract void Paint();
  
  abstract void Work();
  
  void TransmitOutput(){
    for (int i=0;i<outputComponents.length; i++){
      Component c = outputComponents[i];
      if (c!=null){
        c.inputs[outputComponentsIndices[i]] = outputs[i];
        c.Work();
      }
      //println("ERROR: No output-component for "+this+" at index " + i+" specified");
    }
  }
  
  void setupIO(){
    inputComponents = new Component[inputSize];
    inputs = new boolean[inputSize];
    outputComponents = new Component[outputSize];
    outputs = new boolean[outputSize];  
    outputComponentsIndices = new int[outputSize];
  }
}

void WorkAllComponents(){
  for (Component c : allComponents){
    if (c instanceof Schalter){
      c.Work();
    }
  }
}