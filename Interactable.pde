class Interactable {

  float x, y, w, h;
  PImage img;
  float dir;
  boolean visible;
  String name;
  Menu menu;

  Interactable(String name, String imgPath) {
    this.name = name;

    if (imgPath != null) {
      try {
        img = loadImage(imgPath);
      } 
      catch(Exception e) {
        println("ERROR: Could not load image with path: " + imgPath);
        img = null;
      }
    } else {
      img = null;
    }

    dir = 0;
    visible = true;

    interactables.add(this);

    menu = new Menu(name, x, y);
  }

  void setBounds(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    if (img != null) img.resize((int)w, (int)h);
    menu.setPos(x, y);
  }

  void addMenuPoint(String parentName, String menuName) {
    Menu toAdd = menu.lookFor(parentName);
    
    if (toAdd != null) {
      Menu newMenu = new Menu(menuName, toAdd);
      toAdd.addMenuPoint(newMenu);
    } else {
      println("ERROR: Could not find menu with name: " + parentName);
    }
  }

  void setDir(float d) {
    dir = d;
  }

  boolean detectCollision(PVector mouse) {
    float s = sin(-dir);
    float c = cos(-dir);

    mouse.sub(new PVector(x, y));

    float newX = mouse.x * c - mouse.y * s;
    float newY = mouse.x * s + mouse.y * c;

    mouse = new PVector(newX, newY).add(new PVector(x, y));

    /* DEBUG:
     stroke(255, 0, 0);
     strokeWeight(10);
     point(mouse.x, mouse.y);
     strokeWeight(1);
     rect(x - w * .5, y - h * .5, w, h);
     */
     
    return (mouse.x > x - w * .5 && mouse.x < x + w * .5 && mouse.y > y - h * .5 && mouse.y < y + h * .5);
  }

  void mousePressed() {
    if (detectCollision(getCoords(mouseX, mouseY))) {
      currentMenu = menu;
    }
  }

  void draw() {
    if (visible) {
      if (img != null) {
        pushMatrix();
        translate(x, y);
        rotate(dir);
        image(img, -w * .5, -h * .5);
        popMatrix();
      } else {
        stroke(0);
        strokeWeight(1 / zoom);
        noFill();
        pushMatrix();
        translate(x, y);
        rotate(dir);
        rect(-w * .5, -h * .5, w, h);
        popMatrix();
      }
    }
  }
}
