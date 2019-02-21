enum State {
  STATIC, 
    IN_HANGAR, IN_KFZHALLE, 
    HAT_KULLER
}

class Interactable {

  float x, y, w, h;
  PImage img;
  float dir;
  boolean visible;
  String name, jsonPath;
  JSONArray jMenu;
  Menu menu;
  ArrayList<State> states;

  Interactable(String name) {
    this(name, null);
  }

  Interactable(String name, String imgPath) {
    this.name = name;
    setImage(imgPath);

    dir = 0;
    visible = true;

    interactables.add(this);

    jMenu = null;
    menu = new Menu(name, x, y);

    states = new ArrayList<State>();
  }

  void addState(State s) {
    if (!states.contains(s)) states.add(s);
  }

  void addStates(String[] strSta) {
    for (String s : strSta) {
      addState(State.valueOf(s));
    }
  }

  void removeState(State s) {
    if (!states.contains(s)) states.add(s);
  }

  void setImage(String imgPath) {
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
  }

  void setBounds(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    if (img != null) img.resize((int)w, (int)h);
    menu.setPos(x, y);
  }

  Menu addMenuPoint(String parentName, String menuName) {
    Menu toAdd = menu.lookFor(parentName);
    return addMenuPoint(toAdd, menuName);
  }

  Menu addMenuPoint(Menu parentMenu, String menuName) {
    if (parentMenu != null) {
      Menu newMenu = new Menu(menuName, parentMenu);
      parentMenu.addMenuPoint(newMenu);
      return newMenu;
    } else {
      println("ERROR: Could not add menu with name: " + parentMenu.title);
    }

    return null;
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

  void loadMenu() {
    menu = new Menu(name, x, y);
    addMenu(this, this, menu, toObjectArray(jMenu));
  }

  void mousePressed() {
    if (visible && detectCollision(getCoords(mouseX, mouseY))) {
      loadMenu();

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
