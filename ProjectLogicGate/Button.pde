import java.util.function.Function;
class Button {
  int x;
  int y;

  int bheight;
  int bwidth;

  String label;

  //Function action;
  public Button(int x, int y, int bwidth, int bheight, String label) {
    //this.action = _action;
    this.x = x;
    this.y = y;
    this.bheight = bheight;
    this.bwidth = bwidth;
    this.label = label;
  }

  void Draw() {
    fill(255);
    stroke(50);
    rect(x, y, bwidth, bheight);
    textSize(12);
    fill(0);
    text(label, x+5, y+15);
    textSize(25);
  }

  boolean mouseOverButton() {
    return mouseX >= this.x && mouseX <= this.x+this.bwidth && mouseY>=this.y && mouseY<=this.y+this.bheight;
  }

  /*void DoAction(){
   this.action.apply(null);
   }*/
}  