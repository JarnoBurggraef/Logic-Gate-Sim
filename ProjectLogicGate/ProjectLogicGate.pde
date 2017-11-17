Gate a;
ArrayList<Gate> list;
int mouseXoff, mouseYoff, lockedItem, linedItem, linex, liney;
boolean locked, lined, changed;

void setup() {
  size(1000, 800);
  list = new ArrayList<Gate>();
  a = new Gate(20, 20, "and");
  a.toolbar=true;
  list.add(a);
  a = new Gate(10, 350, "or");
  list.add(a);
  /*a = new Gate(10, 400, "schalter");
  list.add(a);
  a = new Gate(10, 450, "lamp");
  list.add(a);
  println(list.size(), ":");
  for (Gate a : list) {
    println(a.type);
  }*/
  textSize(25);
}


////////////////////////////////////////////////////////////////
void draw() {
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
}