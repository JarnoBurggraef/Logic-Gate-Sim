class Gate {
  String type;
  int pointerIndex, x, y, xsize, ysize;
  boolean move, inTop, inBottom, outTop, output;  //inTop ist auch der Eingang für NOTs oder die Schalter
  Gate(int xpos, int ypos, String newType) {
    x=xpos;
    y=ypos;
    type = newType;
    if (type.equals("and")||type.equals("or")) {
      xsize=100;
      ysize=120;
    } else if (type.equals("schalter")) {
      xsize=100;
      ysize=30;
    } else if (type.equals("lamp")) {
      xsize=85;
      ysize=60;
    }
    pointerIndex=-1;
  }
  void paint() {
    stroke(0);
    //Anzeige, dass das Gatter bewegt wird
    fill(255);
    if (this.move) {
      if (locked) {
        stroke(250, 0, 0);
      } else {
        stroke(0);
        move = false;
      }
    }
    //Gatterfläche
    rect(x, y, xsize, ysize);
    //Outputfläche
    if(!type.equals("lamp")){
    rect(x+xsize-25, y+ysize/2-10, 20, 20);}
    //Inputflächen
    if (type.equals("and")) {
      rect(x+5, y+20, 20, 20);
      rect(x+5, y+80, 20, 20);
      fill(0);
      text("&", x+40, y+70);
    } else if (type.equals("or")) {
      rect(x+5, y+20, 20, 20);
      rect(x+5, y+80, 20, 20);
      fill(0);
      text(">=1", x+10, y+70);
    } else if (type.equals("schalter")) {
      if (inTop)fill(0, 255, 0);
      else fill(255, 0, 0);
      rect(x+5, y+5, 40, 20);
    } else if (type.equals("lamp")) {
      if (inTop)fill(0, 255, 0);
      else fill(255, 0, 0);
      rect(x+30, y+5, 50, 50);
      fill(255);
      rect(x+5, y+20, 20, 20);
    }
    stroke(0);
  }

  void paintCable() {
    if (pointerIndex>=0) {
      fill(0);
      if (output) {
        fill(255, 30, 10);
      }
      Gate dest = list.get(pointerIndex);
      if (outTop) {
        line(x+xsize-15, y+ysize/2, dest.x+15, dest.y+30);
      } else {
        line(x+xsize-15, y+ysize/2, dest.x+15, dest.y+90);
      }
    }
  }
  void work() {
    if (pointerIndex>=0) {
      Gate dest = list.get(pointerIndex);
      if (type.equals("and")) {
        output=inTop&&inBottom;
      } else if (type.equals("or")) {
        output=inTop||inBottom;
      } else if (type.equals("schalter")) {
        output=inTop;
      }
      if (outTop) {
        dest.inTop=output;
      } else {
        dest.inBottom=output;
      }
      dest.work();
    }
  }
}