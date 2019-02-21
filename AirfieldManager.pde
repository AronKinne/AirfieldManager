import java.util.Map;
import java.util.Arrays;

float centerX, centerY, zoom;
PImage airfield;
ArrayList<Interactable> interactables;
Menu currentMenu;

void setup() {
  size(1600, 900, P2D);
  smooth();

  interactables = new ArrayList<Interactable>();
  createInteractables("data/interactables");
  currentMenu = null;

  airfield = loadImage("data/images/airfield.png");
  airfield.resize(1600, 900);

  centerX = width * .5;
  centerY = height * .5;
  zoom = 1;
}

void draw() {
  background(255);
  keyHandler();
  zoom(centerX, centerY, zoom);

  // this is needed for sharp text at zoom
  text("", 0, 0);

  image(airfield, 0, 0);
  for (Interactable i : interactables) if(i.visible) i.draw();

  if (currentMenu != null) {
    currentMenu.draw();
  }
}

void zoom(float x, float y, float z) {
  translate(width, height);
  scale(z);
  translate(-width / zoom * .5 - x, -height / zoom * .5 - y);
}

PVector getCoords(float x, float y) {
  float outX = -width * .5 / zoom + centerX + x / zoom;
  float outY = -height * .5 / zoom + centerY + y / zoom;
  return new PVector(outX, outY);
}

PVector getPixels(float x, float y) {
  float outX = width * .5 - centerX * zoom + x * zoom;
  float outY = height * .5 - centerY * zoom + y * zoom;
  return new PVector(outX, outY);
}
