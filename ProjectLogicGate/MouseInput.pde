void mousePressed() {
  for (int i = allComponents.size()-1; i>=0; i--) { 
    Component component = allComponents.get(i);
    ///////////////////////////////
    if (!component.toolbar) {
      for (int j = 0; j<component.outputSize; j++) {
        int[] pos = component.getCableEndPos(j, 1);
        if (inside(pos[0], pos[1], pos[0]+20, pos[1]+20)) {
          drawLine = true;
          linex = mouseX;
          liney = mouseY;
          lineStartIndex = j;
          lineStart = component;
          return;
        }
      }
      if (component instanceof Schalter) {
        if (inside(component.x+5, component.y+5, component.x+45, component.y+25)) {
          component.inputs[0]^=true;
          return;
        }
      }
    }

    //////////////////////////////
    if (inside(component.x, component.y, component.x+component.xsize, component.y+component.ysize)) {
      locked = true;
      if (component.toolbar) {
        if (component instanceof AndGate)
          activeComponent = new AndGate();
        else if (component instanceof OrGate)
          activeComponent = new OrGate();
        else if (component instanceof NotGate)
          activeComponent = new NotGate();
        else if (component instanceof Schalter)
          activeComponent = new Schalter();
        else if (component instanceof Lampe)
          activeComponent = new Lampe();
        else if (component instanceof Splitter)
          activeComponent = new Splitter();
          else if (component instanceof TextBox)
          activeComponent = new TextBox();
        activeComponent.x = component.x;
        activeComponent.y = component.y;
        activeComponent.isMoving=true;
        mouseXoff=mouseX-activeComponent.x;
        mouseYoff=mouseY-activeComponent.y;
      } else {
        activeComponent = component;
        component.isMoving=true;
        lockedItem = i;
        mouseXoff=mouseX-component.x;
        mouseYoff=mouseY-component.y;
      }
    }
  }
}

boolean inside(int minx, int  miny, int maxx, int maxy) {
  if (minx<mouseX && mouseX<maxx) {
    if (miny<mouseY && mouseY<maxy) {
      return true;
    }
  }
  return false;
}

void mouseReleased() {
  if (locked) {
    activeComponent.isMoving = false;
    if (mouseY<160) {
      allComponents.remove(activeComponent);
      drawLine=false;
    }
    activeComponent = null;
  }
  locked = false;
  if (drawLine) {
    drawLine=false;
    lineStart.outputComponents[lineStartIndex] = null;
    lineStart.outputComponentsIndices[lineStartIndex] = 0;
    for (int i = allComponents.size()-1; i>=0; i--) {
      Component comp = allComponents.get(i);
      if (comp.toolbar)continue;

      for (int j = 0; j<comp.inputSize; j++) {
        int[] pos = comp.getCableEndPos(j, 0);
        if (inside(pos[0], pos[1], pos[0]+20, pos[1]+20)) {
          lineStart.outputComponents[lineStartIndex] = comp;
          lineStart.outputComponentsIndices[lineStartIndex] = j;
          break;
        }
      }
    }
  }
  if (SaveToBtn.mouseOverButton()) {
    SaveTo();
  } else if (NewBtn.mouseOverButton()){
    New();
  } else if (LoadBtn.mouseOverButton()){
    Load();
  } else if (LoadBlockBtn.mouseOverButton()){
    LoadBlock();
  }
  for (Component c : allComponents) {
    if (c.toolbar) continue;
    if (inside(c.x, c.y, c.x+c.xsize, c.y+c.ysize) && mouseButton == RIGHT) {
      if (c instanceof Schalter) {
        ((Schalter)c).isInputSchalter = !((Schalter)c).isInputSchalter;
      } else if (c instanceof Lampe) {
        ((Lampe)c).isOutputLampe = !((Lampe)c).isOutputLampe;
      }
    }
  }
  save("save.txt");
  WorkAllComponents();
}