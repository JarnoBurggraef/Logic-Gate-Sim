import java.io.*;
import java.nio.file.*;


Component activeComponent;
//ArrayList<Gate> list;
int mouseXoff, mouseYoff, lockedItem, lineStartIndex, linex, liney;
boolean locked, drawLine, changed;
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
String path(String name){
  //return System.getProperty("." + File.separator + name);
  //return System.getProperty("user.dir") + File.separator + name;
  return Paths.get("").toAbsolutePath().toString()+"/"+name;
}

boolean loadData = false;
void setup(){
  sketch = this;
  size(1000,800);
  if (loadData){
    load();
  } else{
    Component t = new AndGate(20,20);
    t.toolbar = true;
    t = new OrGate(140,20);
    t.toolbar = true;
    t = new NotGate(260,20);
    t.toolbar = true;
    t = new Schalter(380,20);
    t.toolbar = true;
    t = new Lampe(500,20);
    t.toolbar = true;
    t = new Splitter(620,20);
    t.toolbar = true;
  }
  
  textSize(25);
}

void save(){
  FileOutputStream fout = null;
    ObjectOutputStream oos = null;

    try {
      fout = new FileOutputStream(path("data.txt"));
      oos = new ObjectOutputStream(fout);
      oos.writeObject(allComponents);

      System.out.println("Done");

    } catch (Exception ex) {

      ex.printStackTrace();

    } finally {

      if (fout != null) {
        try {
          fout.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }

      if (oos != null) {
        try {
          oos.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }

    }
}
void load(){
  try {
    ObjectInputStream ois = new ObjectInputStream(new FileInputStream(path("data.txt")));

      ArrayList<Component> allComponents = (ArrayList<Component>) ois.readObject();
      println(allComponents.size());
      print("succes");
      ois.close();

 } catch (Exception ex) {
      ex.printStackTrace();
 }
}

void WorkAllComponents(){
  for (Component c : allComponents){
    if (c instanceof Schalter){
      c.Work();
    }
  }
}

void DrawAllComponents(){
  for (Component c : allComponents){
    println(c.x);
    c.Paint();
  }
  for (Component c : allComponents){
    c.DrawCables();
  }
}

void draw(){
  clear();
  background(200);
  toolbar();
  
  DrawAllComponents();
  
  if (locked){
    activeComponent.x = mouseX-mouseXoff;
    activeComponent.y = mouseY-mouseYoff;
  }
  
  if (drawLine){
    fill(0);
    line(linex,liney,mouseX,mouseY);
  }
  
  if (keyPressed){
    if (key=='s'){
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