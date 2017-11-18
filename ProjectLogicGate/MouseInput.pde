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
  save2();
  WorkAllComponents();
}

/*void mousePressed() {
 for (int i = list.size()-1; i>=0; i--) { 
 Gate gate = list.get(i);
 ///////////////////////////////
 if (inside(gate.x+gate.xsize-25, gate.y+gate.ysize/2-10, gate.x+gate.xsize-5, gate.y+gate.ysize/2+10)&&!gate.toolbar) {
 lined = true;
 linex=mouseX;
 liney=mouseY;
 linedItem=i;
 break;
 }////////////////////////////
 if (gate.type.equals("schalter")) {
 if (inside(gate.x+5, gate.y+5, gate.x+45, gate.y+25)) {
 gate.inTop^=true;
 break;
 }
 }
 //////////////////////////////
 if (inside(gate.x, gate.y, gate.x+gate.xsize, gate.y+gate.ysize)) {
 locked = true;
 if (gate.toolbar) {
 switch(gate.type) {
 case "and": 
 a = new Gate(20, 20, "and"); 
 break;
 case "or": 
 a = new Gate(140, 20, "or");
 break;
 case "schalter": 
 a = new Gate(260, 20, "schalter");
 break;
 case "lamp": 
 a = new Gate(380, 20, "lamp");
 break;
 case "not": 
 a = new Gate(485, 20, "not");
 break;
 }
 a.move=true;
 mouseXoff=mouseX-a.x;
 mouseYoff=mouseY-a.y;
 list.add(a);
 lockedItem = list.size()-1;
 } else {
 //println("locked");
 gate.move=true;
 lockedItem = i;
 mouseXoff=mouseX-gate.x;
 mouseYoff=mouseY-gate.y;
 break;
 }
 }
 }
 }
 
 
 void mouseReleased() {
 locked = false;
 //println("unlocked");
 if (lined) {
 lined=false;
 Gate source = list.get(linedItem);
 source.pointerIndex=-1;
 for (int i = list.size()-1; i>=0; i--) {
 Gate gate = list.get(i);
 if (gate.toolbar)continue;
 if (inside(gate.x+5, gate.y+20, gate.x+25, gate.y+40)) {
 source.pointerIndex=i;
 source.outTop=true;
 break;
 } else if (inside(gate.x+5, gate.y+80, gate.x+25, gate.y+120)) {
 source.pointerIndex=i;
 source.outTop=false;
 break;
 } else if (gate.type.equals("lamp")) { 
 if (inside(gate.x+5, gate.y+20, gate.x+25, gate.y+40)) {
 source.pointerIndex=i;
 source.outTop=true;
 break;
 }
 }
 }
 }
 }*/