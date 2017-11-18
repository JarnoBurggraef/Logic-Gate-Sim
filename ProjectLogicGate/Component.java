import java.io.Serializable;
import processing.core.*;
import static processing.core.PApplet.*;

class Component implements Serializable {
  int x, y, xsize, ysize;

  boolean isMoving = false;

  boolean toolbar = false;

  Component[] inputComponents;
  boolean[] inputs;
  int inputSize;


  Component[] outputComponents;
  int[] outputComponentsIndices;
  boolean[] outputs;
  int outputSize;

  transient PApplet sketch;

  Component(int _x, int _y) {
    x = _x;
    y = _y;
    sketch  = ProjectLogicGate.sketch;
    ProjectLogicGate main = (ProjectLogicGate)sketch;
    if (!main.allComponents.contains(this)) {
      main.allComponents.add(this);
    }
  }
  Component() {
    this(0, 0);
  }

  int getEdgeColor() {
    return isMoving ? sketch.color(255, 0, 0) : sketch.color(0);
  }
  void DrawBackground() {
    sketch.fill(255);
    sketch.stroke(getEdgeColor());
    sketch.rect(x, y, xsize, ysize);
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
    sketch.fill(255);
    sketch.stroke(getEdgeColor());
    for (int i = 0; i<inputSize; i++) {
      int[] pos = getCableEndPos(i, 0);
      sketch.rect(pos[0], pos[1], 20, 20);
    }

    for (int i = 0; i<outputSize; i++) {
      int[] pos = getCableEndPos(i, 1);
      sketch.rect(pos[0], pos[1], 20, 20);
    }
  }
  void DrawCables() {
    for (int i = 0; i<outputComponents.length; i++) {
      if (outputs[i]) {
        sketch.stroke(255, 30, 10);
      } else {
        sketch.stroke(0);
      }
      if (outputComponents[i]==null) continue;
      int[] start = getCableEndPos(i, 1);
      int[] end = outputComponents[i].getCableEndPos(outputComponentsIndices[i], 0);
      sketch.line(start[0]+10, start[1]+10, end[0]+10, end[1]+10);
    }
    sketch.stroke(0);
  }

  void TransmitOutput() {
    for (int i=0; i<outputComponents.length; i++) {
      Component c = outputComponents[i];
      if (c!=null) {
        c.inputs[outputComponentsIndices[i]] = outputs[i];
        c.Work();
      }
      //println("ERROR: No output-component for "+this+" at index " + i+" specified");
    }
  }

  void setupIO() {
    inputComponents = new Component[inputSize];
    inputs = new boolean[inputSize];
    outputComponents = new Component[outputSize];
    outputs = new boolean[outputSize];  
    outputComponentsIndices = new int[outputSize];
  }
}