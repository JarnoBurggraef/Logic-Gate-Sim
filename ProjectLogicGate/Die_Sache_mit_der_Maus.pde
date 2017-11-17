void mousePressed() {
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
          a = new Gate(265, 80, "lamp");
          break;
        case "not": 
          a = new Gate(380, 20, "not");
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

boolean inside(int minx, int  miny, int maxx, int maxy) {
  if (minx<mouseX && mouseX<maxx) {
    if (miny<mouseY && mouseY<maxy) {
      return true;
    }
  }
  return false;
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
      } else if (gate.type.equals("not")) { 
        if (inside(gate.x+5, gate.y+30, gate.x+25, gate.y+50)) {
          source.pointerIndex=i;
          source.outTop=true;
          break;
        }
      }
    }
  }
}