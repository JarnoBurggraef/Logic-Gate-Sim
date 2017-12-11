Component activeComponent, textc;
int mouseXoff, mouseYoff, lockedItem, lineStartIndex, linex, liney;
boolean locked, drawLine, changed,writing;
Component lineStart;
ArrayList<Component> allComponents = new ArrayList<Component>();
//ArrayList<Button> allButtons = new ArrayList<Button>();
Button NewBtn;
Button SaveToBtn;
Button LoadBlockBtn;
Button LoadBtn;

int TOOLBARSIZE = 0;

boolean loadData = true;
void setup() {
  size(1000, 800);
  //SetupToolbar();
  if (loadData) {
    load("save.txt");
  } 
  textSize(25);

  NewBtn = new Button(width-100, 200, 70, 30, "New");
  SaveToBtn = new Button(width-100, 250, 70, 30, "Save To");
  LoadBtn = new Button(width-100, 300, 70, 30, "Load");
  LoadBlockBtn = new Button(width-100, 350, 70, 30, "Load Block");
}
void SetupToolbar() {
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
  t = new TextBox(740, 20);
  t.toolbar = true;

  TOOLBARSIZE = 0;
  for (Component c : allComponents) {
    if (c.toolbar) TOOLBARSIZE ++;
  }
}
void New() {
  allComponents = new ArrayList<Component>();
  SetupToolbar();
}

void SaveTo() {
  selectOutput("Select a location to save", "SaveToOut");
}
void SaveToOut(File selection) {
  if (selection!=null) {
    save(selection.getAbsolutePath());
  }
}

void Load() {
  selectInput("Select a file", "LoadFile");
}
void LoadFile(File selection) {
  if (selection != null) {
    load(selection.getAbsolutePath());
  }
}

void LoadBlock() {
  selectInput("Select a file", "LoadBlockFile");
}
void LoadBlockFile(File selection) {
  if (selection==null) return;
  String[] read;
  try {
    read = loadStrings(selection.getAbsolutePath());
    println("There are " + read.length + " obects in the save file.");
  } 
  catch(Exception e) {

    return;
  }
  ArrayList<Component> blockComponents = new ArrayList<Component>();
  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    Component u = allComponents.get(0);
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
    case "textBox":
      u = new TextBox(int(data[1]), int(data[2])); 
      break;
    case "block":
      //TODO
      break;
    }
    if (u instanceof Lampe) {
      ((Lampe)u).isOutputLampe = data[3]=="0" ? false : true;
    } else if (u instanceof Schalter) {
      ((Schalter)u).isInputSchalter = data[3]=="0" ? false : true;
    }
    blockComponents.add(u);
  }

  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    Component u = blockComponents.get(i);
    u.hidden = true;
    for (int  j = 4; j<data.length; j++) {
      String[] tuple =split(data[j], ";");
      if (!tuple[0].equals("-1")) {
        u.outputComponents[j-4]=blockComponents.get(int(tuple[0])-TOOLBARSIZE);
        u.outputComponentsIndices[j-4] = int(tuple[1]);
      }
    }
  }
  Block b = new Block(width/2, height/2, blockComponents);
  String[] nlis = selection.getAbsolutePath().split("/");
  b.name = nlis[nlis.length-1];
}



void save(String name) {
  int acsize=allComponents.size();
  String[] savedObjects = new String[acsize-TOOLBARSIZE];
  String gateType = "";
  for (int ci=0; ci<acsize; ci++) {
    Component d = allComponents.get(ci);
    if (d.toolbar) continue;
    int i = ci-TOOLBARSIZE;

    if (d instanceof Splitter) gateType="splitter";
    else if (d instanceof AndGate)  gateType="and";
    else if (d instanceof OrGate)  gateType="or";
    else if (d instanceof NotGate)  gateType="not";
    else if (d instanceof Schalter)  gateType="schalter";
    else if (d instanceof Lampe)  gateType="lampe";
    else if (d instanceof TextBox)  gateType="textBox";
    else if (d instanceof Block) gateType="block";
    savedObjects[i]=gateType+","+d.x+","+d.y+",";
    String IOState = "0";
    if (d instanceof Lampe)  IOState = ((Lampe)d).isOutputLampe ? "1" : "0";
    else if (d instanceof Schalter)  IOState = ((Schalter)d).isInputSchalter ? "1" : "0";
    else if (d instanceof TextBox)  IOState = d.text;
    savedObjects[i] += IOState+",";
    //if (gateType != "block"){
    for (int j=0; j<d.outputComponents.length; j++) {
      int index = d.outputComponents[j] == null ? -1 : allComponents.indexOf(d.outputComponents[j]);
      savedObjects[i] += index + ";"+d.outputComponentsIndices[j];
      if (j!= d.outputComponents.length-1 || gateType == "block") {
        savedObjects[i] += ",";
      }
    }
    if (gateType == "block") {
      for (int j=0; j<((Block)d).innerComponents.size(); j++) {
        savedObjects[i] += allComponents.indexOf(((Block)d).innerComponents.get(j));
        if (j!=((Block)d).innerComponents.size()-1) savedObjects[i] += ";";
      }
      savedObjects[i] += ","+((Block)d).name;
    }
  }
  saveStrings(name, savedObjects);
}
void load(String name) {
  String[] read;
  New();
  try {
    read = loadStrings(name);
    println("There are " + read.length + " obects in the save file.");
  } 
  catch(Exception e) {

    return;
  }
  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    //printArray(data);
    Component u = allComponents.get(0);
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
    case "textBox":
      u = new TextBox(int(data[1]), int(data[2])); 
      break;
    case "block":
      u = new Block(int(data[1]), int(data[2]), new ArrayList<Component>());
      break;
    case "null":
      continue;
    }
    if (u instanceof Lampe) {
      ((Lampe)u).isOutputLampe = data[3]=="0" ? false : true;
    } else if (u instanceof Schalter) {
      ((Schalter)u).isInputSchalter = data[3]=="0" ? false : true;
    } else if (u instanceof TextBox) {
      ((TextBox)u).text = data[3];
    }
  }

  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    Component u = allComponents.get(i+TOOLBARSIZE);
    int end = data.length;
    if (u instanceof Block) {
      String[] innerC = split(data[data.length-2], ";");
      ArrayList<Component> innerComponents = new ArrayList<Component>();
      for (String c : innerC) {
        Component comp = allComponents.get(int(c));
        if (comp.toolbar) continue;
        comp.hidden = true;
        innerComponents.add(comp);
      }
      ((Block)u).innerComponents = innerComponents;
      ((Block)u).loadIO();
      ((Block)u).name = data[data.length-1];
      end = data.length-2;
    }
    for (int  j = 4; j<end; j++) {
      String[] tuple =split(data[j], ";");
      if (int(tuple[0])>=0&&tuple.length>1) {
        u.outputComponents[j-4]=allComponents.get(int(tuple[0]));
        u.outputComponentsIndices[j-4] = int(tuple[1]);
      }
    }
  }
  WorkAllComponents();
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
    if (!c.hidden)
      c.Paint();
  }
  for (Component c : allComponents) {
    if (!c.hidden)
      c.DrawCables();
  }
}

void draw() {
  clear();
  background(200);
  toolbar();

  DrawAllComponents();
  NewBtn.Draw();
  SaveToBtn.Draw();
  LoadBtn.Draw();
  LoadBlockBtn.Draw();

  if (locked) {
    activeComponent.x = mouseX-mouseXoff;
    activeComponent.y = mouseY-mouseYoff;
  }

  if (drawLine) {
    fill(0);
    line(linex, liney, mouseX, mouseY);
  }
}