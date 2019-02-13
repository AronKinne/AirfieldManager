class Menu {

  final Menu parent;
  String title;
  float xo, yo, wb, hb, spacing;

  ArrayList<Menu> menus;
  ArrayList<Button> buttons;
  HashMap<Button, Menu> hm;

  Menu(String title, float x, float y) {
    this.title = title;
    this.parent = null;
    xo = x;
    yo = y;
    wb = 300;
    hb = 25;
    spacing = 5;
    buttons = new ArrayList<Button>();
    menus = new ArrayList<Menu>();
    hm = new HashMap<Button, Menu>();

    buttons.add(new Button(xo + spacing, yo + 2 * spacing + hb, wb, hb, "Menü schließen") {
      void clicked() {
        currentMenu = null;
      }
    }
    );
  }

  Menu(String title, Menu p) {
    this.title = title;
    parent = p;
    xo = p.xo;
    yo = p.yo;
    wb = p.wb;
    hb = p.hb;
    spacing = p.spacing;
    buttons = new ArrayList<Button>();
    menus = new ArrayList<Menu>();
    hm = new HashMap<Button, Menu>();
    p.menus.add(this);

    buttons.add(new Button(xo + spacing, yo + 2 * spacing + hb, wb, wb, "Zurück") {
      void clicked() {
        currentMenu = parent;
      }
    }
    );
  }

  Menu lookFor(String search) {
    if (title == search) {
      return this;
    } else {
      for (Menu m : menus) return m.lookFor(search);
    }
    return null;
  }
  
  void setPos(float x, float y) {
    xo = x;
    yo = y;

    for (int i = 1; i <= buttons.size(); i++) {
      float posY = yo + spacing + i * (hb + spacing); 
      buttons.get(i - 1).setPos(xo + spacing, posY);
    }
  }
  
  void addMenuPoint(Menu m) {
    Button b = new Button(xo + spacing, yo + spacing + (buttons.size() + 1) * (hb + spacing), wb, hb, m.title) {
       public void clicked() {
          currentMenu = hm.get(this); 
       }
    };
    hm.put(b, m);
    buttons.add(buttons.size() - 1, b);
    menus.add(m);
  }
  
  boolean mousePressed() {
    boolean out = false;
    for(Button b : buttons) {
      if(b.mousePressed()) {
        out = true;
        break;
      }
    }
    return out;
  }

  void draw() {
    wb = 300 / zoom;
    hb = 25 / zoom;
    spacing = 5 / zoom;
    for (int i = 1; i <= buttons.size(); i++) { 
      float posY = yo + spacing + i * (hb + spacing); 
      buttons.get(i - 1).setPos(xo + spacing, posY);
      buttons.get(i - 1).setSize(wb, hb);
      buttons.get(i - 1).textSize = 15 / zoom;
      buttons.get(i - 1).strokeWeight = 1 / zoom;
    }

    stroke(0);
    fill(255);
    rect(xo, yo, wb + 2 * spacing, spacing + (buttons.size() + 1) * (hb + spacing));

    fill(0);
    textSize(15 / zoom);
    textAlign(LEFT, TOP);
    text(title, xo + spacing, yo + spacing);

    for (Button b : buttons) {
      b.draw();
    }
  }
}
