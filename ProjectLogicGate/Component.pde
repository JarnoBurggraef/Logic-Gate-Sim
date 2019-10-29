class Component {
  int x, y, xsize, ysize;
  boolean hidden = false;
  boolean isMoving = false;
  boolean toolbar = false;
  boolean[] inputs;
  boolean[] outputs;
  int[] outputComponentsIndices;
  int inputSize;
  int outputSize;
  Component[] outputComponents;
  String text;

  Component(int _x, int _y) {
    x = _x;
    y = _y;
    if (!allComponents.contains(this)) {
      allComponents.add(this);
    }
  }
  
  Component() {
    this(0, 0);
  }

  int getEdgeColor() {
    return isMoving ? color(255, 0, 0) : color(0);
  }
  
  void drawBackground() {
    fill(255);
    stroke(getEdgeColor());
    rect(x, y, xsize, ysize);
  }

  void Paint() {
  }

  void Work() {
  }

  void drawStandardStuff() {
    drawBackground();
    drawIO();
  }

  int[] getCableEndPos(int index, int row) {
    int _x = row == 0 ? x+5 : x+xsize-25;
    int _y = y+(int)(ysize*((float)(index+1)/((row==0 ? inputSize : outputSize)+1))) -10; 
    return new int[]{_x, _y};
  }

  void drawIO() {
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
  void drawCables() {
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
    inputs = new boolean[inputSize];
    outputComponents = new Component[outputSize];
    outputs = new boolean[outputSize];  
    outputComponentsIndices = new int[outputSize];
  }
}
