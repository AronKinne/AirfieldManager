import java.util.Map;
import java.util.Arrays;

float centerX, centerY, zoom;
PImage airfield;
ArrayList<Interactable> interactables;
Menu currentMenu;
String activeFunc;
Interactable activeInter, apron;

void setup() {
  size(1600, 900, P2D);
  smooth();

  interactables = new ArrayList<Interactable>();
  
  // Interactables
  createInteractables(getFiles("data/interactables", "static_objects", "planes", "vehicles"));
  // Carryables
  createInteractables(getFiles("data/interactables", "carryables"));
  
  //for(Interactable i : interactables) i.log();
  
  currentMenu = null;

  airfield = loadImage("data/images/airfield.jpg");
  airfield.resize(1600, 900);

  // DEFAULT
  centerX = width * .5;
  centerY = height * .5;
  zoom = 1;
  //
  
  // TEST
  centerX = 1200;
  centerY = 285;
  zoom = 3;
  //
  
  activeFunc = "";
  activeInter = null;
}

void draw() {
  background(255);
  keyHandler();
  zoom(centerX, centerY, zoom);

  // this is needed for sharp text at zoom
  text("", 0, 0);

  image(airfield, 0, 0);
  for (Interactable i : interactables) i.draw();

  if (currentMenu != null) {
    currentMenu.draw();
  }
  
  for(int i = 0; i < interactables.size(); i++) {
    Interactable inter = interactables.get(i);
    String text = inter.name + ": " + join(Arrays.copyOf(inter.states.toArray(), inter.states.toArray().length, String[].class), " ");
    fill(255, 0, 0);
    textAlign(LEFT, TOP);
    textSize(15 / zoom);
    PVector pos = getCoords(0, 15 * i);
    text(text, pos.x, pos.y);
  }
}

void zoom(float x, float y, float z) {
  translate(width, height);
  scale(z);
  translate(-width / zoom * .5 - x, -height / zoom * .5 - y);
}
