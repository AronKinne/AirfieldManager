class Button {

  float x, y, w, h;
  PImage icon;
  String value;
  color bgCol, bgColPressed, borderCol, textCol;
  boolean isPressed;
  float strokeWeight, textSize;
  int hotkey;

  Button(float x_, float y_, float w_, float h_, String v) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    icon = null;
    value = v;
    bgCol = color(200);
    bgColPressed = color(180);
    borderCol = color(0);
    textCol = color(0);
    isPressed = false;
    strokeWeight = 1;
    textSize = 15;
    hotkey = 0;
  }

  void clicked() {
    println("Button clicked");
  }

  void setHotkey(int hk) {
    hotkey = hk;
  }

  void setPos(float posX, float posY) {
    x = posX;
    y = posY;
  }

  PVector getPos() {
    return new PVector(x, y);
  }

  void setSize(float wi, float he) {
    w = wi;
    h = he;
  }

  float getWidth() {
    return w;
  }

  float getHeight() {
    return h;
  }

  void setIcon(PImage image) {
    if (image != null) icon = image;
  }

  void removeIcon() {
    icon = null;
  }

  boolean isPressed() {
    return isPressed;
  }

  void setValue(String v) {
    value = v;
  }

  String getValue() {
    return value;
  }

  void draw() {
    stroke(borderCol);
    if (strokeWeight > 0) strokeWeight(strokeWeight);
    else noStroke();
    fill(isPressed ? bgColPressed : bgCol);
    rect(x, y, w, h);
    if (icon == null) {
      textAlign(CENTER, CENTER);
      textSize(textSize);
      fill(textCol);
      text(value, x + w * 0.5, y + h * 0.5);
    } else {
      icon.resize(int(w), int(h));
      imageMode(CORNER);
      image(icon, x, y);
    }
  }

  void mousePressed() {
    PVector m = getCoords(mouseX, mouseY);

    if (m.x >= x && m.x <= x + w && m.y >= y && m.y <= y + h && mouseButton == LEFT) {
      clicked();
    }
  }
}