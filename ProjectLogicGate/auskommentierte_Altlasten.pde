
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
/*void keyPressed() {
 if (key=='s') {
 save2();
 }
 }*/

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
/*class Gate {
 String type;
 int pointerIndex, x, y, xsize, ysize;
 boolean move, inTop, inBottom, outTop, output, toolbar;  //inTop ist auch der Eingang für NOTs oder die Schalter
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
 xsize=90;
 ysize=60;
 } else if (type.equals("not")) {
 xsize=80;
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
 if (!type.equals("lamp")) {
 rect(x+xsize-25, y+ysize/2-10, 20, 20);
 }
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
 rect(x+35, y+5, 50, 50);
 fill(255);
 rect(x+5, y+20, 20, 20);
 } else if (type.equals("not")) {
 rect(x+5, y+20, 20, 20);
 ellipse(x+90, y+30, 20, 20);
 fill(0);
 text("1", x+33, y+30);
 }
 stroke(0);
 }
 
 void paintCable() {
 if (pointerIndex>=0) {
 if (output) {
 stroke(255, 30, 10);
 }
 Gate dest = list.get(pointerIndex);
 if (outTop) {
 line(x+xsize-15, y+ysize/2, dest.x+15, dest.y+30);
 } else {
 line(x+xsize-15, y+ysize/2, dest.x+15, dest.y+90);
 }
 stroke(0);
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
 } else if (type.equals("not")) {
 output=!inTop;
 }
 if (outTop) {
 dest.inTop=output;
 } else {
 dest.inBottom=output;
 }
 dest.work();
 }
 }
 }*/