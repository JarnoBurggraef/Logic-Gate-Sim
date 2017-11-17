Gate a;
ArrayList<Gate> list;
int mouseXoff, mouseYoff, lockedItem, linedItem, linex, liney;
boolean locked, lined, changed;

void setup() {
  size(1000, 500);
  list = new ArrayList<Gate>();
  a = new Gate(10, 10, "and");
  list.add(a);
  a = new Gate(10, 150, "or");
  list.add(a);
  a = new Gate(10, 300, "schalter");
  list.add(a);
  a = new Gate(10, 350, "schalter");
  list.add(a);
  a = new Gate(10, 400, "lamp");
  list.add(a);
  println(list.size(), ":");
  for (Gate a : list) {
    println(a.type);
  }
  textSize(25);
}


////////////////////////////////////////////////////////////////
void draw() {
  clear();
  background(200);
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