ArrayList<Integer> pressedKeys = new ArrayList<Integer>();

void keyHandler() {
  if (pressedKeys.contains(LEFT)) centerX -= 10 / zoom;
  if (pressedKeys.contains(RIGHT)) centerX += 10 / zoom;
  if (pressedKeys.contains(UP)) centerY -= 10 / zoom;
  if (pressedKeys.contains(DOWN)) centerY += 10 / zoom;
}

void mouseWheel(MouseEvent e) {
  zoom = constrain(zoom - e.getCount() * .1, .5, 5);
}

void keyPressed() {
  //println(keyCode);
  if (!pressedKeys.contains(keyCode)) pressedKeys.add(keyCode);
}

void keyReleased() {
  if (pressedKeys.contains(keyCode)) pressedKeys.remove((Integer)keyCode);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (activeInter != null && activeFunc != "") {
      MethodRelay mr = new MethodRelay(this, activeFunc, Interactable.class, PVector.class);
      mr.execute(activeInter, new PVector(mouseX, mouseY));
      activeInter = null;
      activeFunc = "";
    } else if (currentMenu == null) {
      for (Interactable i : interactables) i.mousePressed();
    } else {
      if (!currentMenu.mousePressed()) currentMenu = null;
    }
  } else if (mouseButton == RIGHT) {
    println(getCoords(mouseX, mouseY));
  }
}
