

class Component {
  int x, y, xsize, ysize;

  boolean isMoving = false;

  boolean toolbar = false;

  //Component[] inputComponents;
  boolean[] inputs;
  int inputSize;


  Component[] outputComponents;
  int[] outputComponentsIndices;
  boolean[] outputs;
  int outputSize;

  Component(int _x, int _y) {
    x = _x;
    y = _y;
    if (allComponents.contains(this)) {
      allComponents.add(this);
    }
  }
  Component() {
    this(0, 0);
  }

  int getEdgeColor() {
    return isMoving ? color(255, 0, 0) : color(0);
  }
  void DrawBackground() {
    fill(255);
    stroke(getEdgeColor());
    rect(x, y, xsize, ysize);
  }

  void Paint() {
  }

  void Work() {
  }

  void DrawStandardStuff() {
    DrawBackground();
    DrawIO();
  }

  int[] getCableEndPos(int index, int row) {
    int _x = row == 0 ? x+5 : x+xsize-25;
    int _y = y+(int)(ysize*((float)(index+1)/((row==0 ? inputSize : outputSize)+1))) -10; 
    return new int[]{_x, _y};
  }

  void DrawIO() {
    fill(255);
    stroke(getEdgeColor());
    for (int i = 0; i<inputSize; i++) {
      int[] pos = getCableEndPos(i, 0);
      rect(pos[0], pos[1], 20, 20);
    }

    for (int i = 0; i<outputSize; i++) {
      int[] pos = getCableEndPos(i, 1);
      rect(pos[0], pos[1], 20, 20);
    }
  }
  void DrawCables() {
    for (int i = 0; i<outputComponents.length; i++) {
      if (outputs[i]) {
        stroke(255, 30, 10);
      } else {
        stroke(0);
      }
      if (outputComponents[i]==null) continue;
      int[] start = getCableEndPos(i, 1);
      int[] end = outputComponents[i].getCableEndPos(outputComponentsIndices[i], 0);
      line(start[0]+10, start[1]+10, end[0]+10, end[1]+10);
    }
    stroke(0);
  }

  void TransmitOutput() {
    for (int i=0; i<outputComponents.length; i++) {
      Component c = outputComponents[i];
      if (c!=null) {
        c.inputs[outputComponentsIndices[i]] = outputs[i];
        c.Work();
      }
    }
  }

  void setupIO() {
    //inputComponents = new Component[inputSize];
    inputs = new boolean[inputSize];
    outputComponents = new Component[outputSize];
    outputs = new boolean[outputSize];  
    outputComponentsIndices = new int[outputSize];
  }
}