Component activeComponent;
int mouseXoff, mouseYoff, lockedItem, lineStartIndex, linex, liney;
boolean locked, drawLine, changed;
String gateType;
Component lineStart;
ArrayList<Component> allComponents = new ArrayList<Component>();

static PApplet sketch;

File directory = new File(".");

boolean loadData = true;
void setup() {
  sketch = this;
  size(1000, 800);
  Component t = new AndGate(20, 20);
  t.toolbar = true;
  t = new OrGate(140, 20);
  t.toolbar = true;
  t = new NotGate(260, 20);
  t.toolbar = true;
  t = new Schalter(380, 20);
  t.toolbar = true;
  t = new Lampe(500, 20);
  t.toolbar = true;
  t = new Splitter(620, 20);
  t.toolbar = true;
  t = new TextBox(720, 20);
  t.toolbar = true;
  println(allComponents.size());
  if (loadData) {
    load();
  } 
  textSize(25);
}

void save() {
  int acsize=allComponents.size();
  String[] savedObjects = new String[acsize];
  for (int i=0; i<acsize; i++) {
    Component d = allComponents.get(i);
    if (d.toolbar) continue;

    if (d instanceof Splitter) gateType="splitter";
    else if (d instanceof AndGate)  gateType="and";
    else if (d instanceof OrGate)  gateType="or";
    else if (d instanceof NotGate)  gateType="not";
    else if (d instanceof Schalter)  gateType="schalter";
    else if (d instanceof Lampe)  gateType="lampe";
    else if (d instanceof TextBox)  gateType="text";

    savedObjects[i]=gateType+","+d.x+","+d.y+",";
    for (int j=0; j<d.outputComponents.length; j++) {
      int index = d.outputComponents[j] == null ? -1 : allComponents.indexOf(d.outputComponents[j]);
      savedObjects[i] += index + ";"+d.outputComponentsIndices[j]+",";
    }
  }
  saveStrings("save.txt", savedObjects);
}
void load() {
  String[] read = loadStrings("save.txt");
  println("There are " + read.length + " obects in the save file.");
  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    Component u;
    switch(data[0]) {
    case "and":
      u = new AndGate(int(data[1]), int(data[2]));
      break;
    case "or":
      u = new OrGate(int(data[1]), int(data[2])); 
      break;
    case "not":
      u = new NotGate(int(data[1]), int(data[2]));  
      break;
    case "schalter":
      u = new Schalter(int(data[1]), int(data[2])); 
      break;
    case "lampe":
      u = new Lampe(int(data[1]), int(data[2])); 
      break;
    case "splitter":
      u = new Splitter(int(data[1]), int(data[2])); 
      break;
    case "text":
      u = new TextBox(int(data[1]), int(data[2])); 
      break;
    }
    println(allComponents.size());
  }
  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    Component u = allComponents.get(i);
    for (int  j = 3; j<data.length; j++) {
      String[] stringtuple = split(data[j], ";");
      // println("data:",data[j]);
      int[] inttuple= new int[stringtuple.length];
      for (byte b =0; b<stringtuple.length; b++) {
        inttuple[b] = int(stringtuple[b]);
      }
      //  println("inttuple[0]:");
      //  println(inttuple[0]);
      if (inttuple[0]>0) {
        u.outputComponents[j-3]=allComponents.get(inttuple[0]);
        //   println("opc:", j-3);
        u.outputComponentsIndices[j-3] = inttuple[1];
      }
    }
  }
}

void WorkAllComponents() {
  for (Component c : allComponents) {
    if (c instanceof Schalter) {
      c.Work();
    }
  }
}
void toolbar() {  
  fill(100);
  rect(0, 0, width, 160);
}

void DrawAllComponents() {
  for (Component c : allComponents) {
    c.Paint();
  }
  for (Component c : allComponents) {
    c.DrawCables();
  }
}

void draw() {
  clear();
  background(200);
  toolbar();

  DrawAllComponents();

  if (locked) {
    activeComponent.x = mouseX-mouseXoff;
    activeComponent.y = mouseY-mouseYoff;
  }

  if (drawLine) {
    fill(0);
    line(linex, liney, mouseX, mouseY);
  }
}