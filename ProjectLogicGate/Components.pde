class Block extends Component  {

  ArrayList<Component> innerComponents = new ArrayList<Component>();
  String name;

  public Block() {
    this(0, 0, new ArrayList<Component>());
  }
  public Block(int _x, int _y, ArrayList<Component> _innerComponents) {
    super(_x, _y);

    xsize = 120;
    ysize = 120;

    innerComponents = _innerComponents;

    inputSize = 0;
    outputSize = 0;

    loadIO();
  }
  void loadIO() {
    for (Component c : innerComponents) {
      if (c instanceof Schalter) {
        if (((Schalter)c).isInputSchalter) {
          inputSize += 1;
        }
      } else if (c instanceof Lampe) {
        if (((Lampe)c).isOutputLampe) {
          outputSize +=1 ;
        }
      }
    }
    setupIO();
  }

  void Paint() {
    DrawStandardStuff();
    textSize(12);
    fill(0);
    textAlign(CENTER);
    text(name, x+xsize/2, y+20);
    textSize(25);
    textAlign(LEFT);
  }
  void Work() {
    int i = 0;
    for (Component c : this.innerComponents) {
      if (c instanceof Schalter) {
        if (((Schalter)c).isInputSchalter) {
          c.inputs[0] = this.inputs[i];
          i++;
          c.Work();
        }
      }
    }
    i = 0;
    for (Component c : this.innerComponents) {
      if (c instanceof Lampe) {
        if (((Lampe)c).isOutputLampe) {
          this.outputs[i] = c.outputs[0];
          i++;
        }
      }
    }
    TransmitOutput();
  }
}

class AndGate extends Component {
  public AndGate() {
    this(0, 0);
  }
  AndGate(int _x, int _y) {
    super(_x, _y);

    xsize = 100;
    ysize = 120;

    inputSize = 2;
    outputSize = 1;

    setupIO();
  }
  void Paint() {
    DrawStandardStuff();
    fill(0);
    text("&", x+40, y+70);
  }
  void Work() {
    outputs[0] = inputs[0] && inputs[1];
    TransmitOutput();
  }
}

class OrGate extends Component {
  OrGate() {
    this(0, 0);
  }
  OrGate(int _x, int _y) {
    super(_x, _y);

    xsize = 100;
    ysize = 120;

    inputSize = 2;
    outputSize = 1;
    setupIO();
  }

  void Paint() {
    DrawStandardStuff();
    fill(0);
    text(">=1", x+15, y+70);
  }

  void Work() {
    outputs[0] = inputs[0] || inputs[1];
    TransmitOutput();
  }
}

class NotGate extends Component {
  NotGate() {
    this(0, 0);
  }
  NotGate(int _x, int _y) {
    super(_x, _y);

    xsize = 100;
    ysize = 30;

    inputSize = 1;
    outputSize = 1;
    setupIO();
  }

  void Paint() {
    DrawStandardStuff();
    fill(0);
    text("!", x+45, y+25);
  }

  void Work() {
    outputs[0] = !inputs[0];
    TransmitOutput();
  }
}

class Schalter extends Component {

  boolean isInputSchalter = false;
  Schalter() {
    this(0, 0);
  }
  Schalter(int _x, int _y) {
    super(_x, _y);

    xsize=100;
    ysize=30;

    inputSize = 1;
    outputSize = 1;
    setupIO();
  }
  void Paint() {
    if (isInputSchalter) {
      fill(color(255, 255, 0));
      rect(x-2, y-2, xsize+4, ysize+4);
    }
    DrawStandardStuff();
    if (inputs[0])fill(0, 255, 0);
    else fill(255, 0, 0);
    rect(x+5, y+5, 40, 20);
  }
  void Work() {
    outputs[0] = inputs[0];
    TransmitOutput();
  }
}

class Lampe extends Component {
  boolean isOutputLampe = false;

  Lampe() {
    this(0, 0);
  }
  Lampe(int _x, int _y) {
    super(_x, _y);

    xsize=85;
    ysize=60;

    inputSize = 1;
    outputSize = 1;
    setupIO();
  }
  void Paint() {
    if (isOutputLampe) {
      fill(color(255, 255, 0));
      rect(x-2, y-2, xsize+4, ysize+4);
    }
    DrawStandardStuff();
    if (outputs[0])fill(0, 255, 0);
    else fill(255, 0, 0);
    rect(x+30, y+5, 50, 50);
    fill(255);
  }
  void Work() {
    outputs[0] = inputs[0];
  }
}
class Splitter extends Component {
  Splitter() {
    this(0, 0);
  }
  Splitter(int _x, int _y) {
    super(_x, _y);
    xsize= 85;
    ysize = 90;

    inputSize = 1;
    outputSize = 2;
    setupIO();
  }
  void Paint() {
    DrawStandardStuff();
  }
  void Work() {
    outputs[0] = inputs[0];
    outputs[1] = inputs[0];
    TransmitOutput();
  }
}

class TextBox extends Component {

  String text="";

  TextBox() {
    this(0, 0);
  }
  TextBox(int _x, int _y) {
    super(_x, _y);
    xsize= 20 + int(textWidth(text));
    ysize = 30;

    inputSize = 0;
    outputSize = 0;
    setupIO();
    text = "";
  }
  void Paint() {
    xsize= 20 + int(textWidth(text));
    DrawStandardStuff();
    textSize(25);
    fill(0);
    //println(text);
    text(text, x+10, y+25);
    textSize(25);
  }
  void Work() {
  }
}