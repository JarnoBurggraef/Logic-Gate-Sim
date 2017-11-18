import java.io.*;
import java.nio.file.*;


Component activeComponent;
//ArrayList<Gate> list;
int mouseXoff, mouseYoff, lockedItem, lineStartIndex, linex, liney;
boolean locked, drawLine, changed;
String gateType;
Component lineStart;
ArrayList<Component> allComponents = new ArrayList<Component>();

static PApplet sketch;

File directory = new File(".");

/*void setup() {
 size(1000, 800);
 list = new ArrayList<Gate>();
 a = new Gate(20, 20, "and");
 a.toolbar=true;
 list.add(a);
 a = new Gate(140, 20, "or");
 a.toolbar=true;
 list.add(a);
 a = new Gate(260, 20, "schalter");
 a.toolbar=true;
 list.add(a);
 a = new Gate(265, 80, "lamp");
 a.toolbar=true;
 list.add(a);
 a = new Gate(380, 20, "not");
 a.toolbar=true;
 list.add(a);
 println(list.size(), ":");
 for (Gate a : list) {
 println(a.type);
 }
 textSize(25);
 }
 */
String path(String name) {
  //return System.getProperty("." + File.separator + name);
  //return System.getProperty("user.dir") + File.separator + name;
  return Paths.get("").toAbsolutePath().toString()+"/"+name;
}

boolean loadData = true;
void setup() {
  sketch = this;
  size(1000, 800);
  if (loadData) {
    load2();
    //load();
  } 
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

  textSize(25);
}

/*void save() {
 FileOutputStream fout = null;
 ObjectOutputStream oos = null;
 
 try {
 fout = new FileOutputStream(path("data.txt"));
 oos = new ObjectOutputStream(fout);
 oos.writeObject(allComponents);
 
 System.out.println("Done");
 } 
 catch (Exception ex) {
 
 ex.printStackTrace();
 } 
 finally {
 
 if (fout != null) {
 try {
 fout.close();
 } 
 catch (IOException e) {
 e.printStackTrace();
 }
 }
 
 if (oos != null) {
 try {
 oos.close();
 } 
 catch (IOException e) {
 e.printStackTrace();
 }
 }
 }
 }*/

void save2() {
  String[] savedObjects = new String[allComponents.size()];
  for (int i=0; i<allComponents.size()-1; i++) {
    Component d = allComponents.get(i);
    if (d.toolbar) continue;

    if (d instanceof Splitter) gateType="splitter";
    else if (d instanceof AndGate)  gateType="and";
    else if (d instanceof OrGate)  gateType="or";
    else if (d instanceof NotGate)  gateType="not";
    else if (d instanceof Schalter)  gateType="schalter";
    else if (d instanceof Lampe)  gateType="lampe";
    savedObjects[i]=gateType+","+d.x+","+d.y+",";
  }
  saveStrings("save.txt", savedObjects);
}
/*void load() {
 try {
 ObjectInputStream ois = new ObjectInputStream(new FileInputStream(path("data.txt")));
 
 ArrayList<Component> allComponents = (ArrayList<Component>) ois.readObject();
 println(allComponents.size());
 print("succes");
 ois.close();
 } 
 catch (Exception ex) {
 ex.printStackTrace();
 }
 }*/
void load2() {
  String[] read = loadStrings("save.txt");
  println("There are " + read.length + " obects in the save file.");
  for ( int i=0; i<read.length; i++) {
    String[] data = split(read[i], ',');
    // println(data[0]);
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

  if (keyPressed) {
    if (key=='s') {
      WorkAllComponents();
    }
  }
}
/*void draw() {
 clear();
 background(200);
 toolbar();
 if (locked) {
 Gate a = list.get(lockedItem);
 a.x=mouseX-mouseXoff;
 a.y=mouseY-mouseYoff;
 }
 for (Gate a : list) {
 if (a.type.equals("schalter")) {
 a.work();
 }
 a.paint();
 }
 for (Gate a : list) {
 a.paintCable();
 }
 if (lined) {
 fill(0);
 line(linex, liney, mouseX, mouseY);
 }
 }*/