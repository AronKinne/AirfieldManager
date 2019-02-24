class Interactable {

  PVector pos, dest;
  float w, h;
  PImage img;
  float dir, initSpeed, speed;
  boolean visible;
  String name, jsonPath;
  JSONArray jMenu;
  Menu menu;
  ArrayList<String> states;

  Interactable(String name) {
    this(name, null);
  }

  Interactable(String name, String imgPath) {
    this.name = name;
    setImage(imgPath);

    pos = new PVector();
    dest = null;
    dir = 0;
    initSpeed = 0;
    speed = 0;
    visible = true;

    interactables.add(this);

    jMenu = null;
    menu = new Menu(name, pos.x, pos.y);

    states = new ArrayList<String>();
  }
  
  void initSpeed(float s) {
    initSpeed = s;
    speed = s;
  }

  void setDest(PVector d) {
    dest = d;
  }

  void addState(String s) {
    if (isNoState(s)) states.add(s);
  }

  void addStates(String[] strSta) {
    for (String s : strSta) {
      addState(s);
    }
  }

  void removeState(String s) {
    if (isState(s)) states.remove(s);
  }

  void removeStates(String[] strSta) {
    for (String s : strSta) {
      removeState(s);
    }
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
    pos = new PVector(x, y);
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

  void addMenuFunction(Menu parentMenu, String name, JSONObject jConclusion) {
    if (parentMenu != null) {
      parentMenu.addMenuFunction(this, name, jConclusion);
    } else {
      println("ERROR: Could not add function to menu with name: " + parentMenu.title);
    }
  }

  void setDir(float d) {
    dir = d;
  }

  void setDirDeg(float d) {
    setDir(radians(d));
  }
  
  boolean isState(String... sta) {
    boolean out = true;
    for(String s : sta) {
      if(!states.contains(s)) {
         out = false;
         break;
      }
    }
    return out;
  }
  
  boolean isNoState(String... sta) {
    boolean out = true;
    for(String s : sta) {
      if(states.contains(s)) {
         out = false;
         break;
      }
    }
    return out;
  }

  boolean detectCollision(PVector mouse) {
    float s = sin(-dir);
    float c = cos(-dir);

    mouse.sub(pos);

    float newX = mouse.x * c - mouse.y * s;
    float newY = mouse.x * s + mouse.y * c;

    mouse = new PVector(newX, newY).add(pos);

    /* DEBUG:
     stroke(255, 0, 0);
     strokeWeight(10);
     point(mouse.x, mouse.y);
     strokeWeight(1);
     rect(x - w * .5, y - h * .5, w, h);
     */

    return (mouse.x > pos.x - w * .5 && mouse.x < pos.x + w * .5 && mouse.y > pos.y - h * .5 && mouse.y < pos.y + h * .5);
  }

  void loadMenu() {
    menu = new Menu(name, pos.x, pos.y);
    addMenu(this, this, menu, toObjectArray(jMenu));
  }

  void mousePressed() {
    if (visible && detectCollision(getCoords(mouseX, mouseY))) {
      loadMenu();

      currentMenu = menu;
    }
  }

  void goTo() {
    if (dest != null) {
      if(PVector.dist(pos, dest) < speed) {
        dest = null;
        speed = initSpeed;
        return;
      }
      
      PVector des = dest.copy().sub(pos);
      des.setMag(speed);

      dir = des.heading() + HALF_PI;
      pos.add(des);
    }
  }

  void draw() {
    goTo();

    if (visible) {
      if (img != null) {
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(dir);
        image(img, -w * .5, -h * .5);
        popMatrix();
      } else {
        stroke(0);
        strokeWeight(1 / zoom);
        noFill();
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(dir);
        rect(-w * .5, -h * .5, w, h);
        popMatrix();
      }
    }
  }
}
