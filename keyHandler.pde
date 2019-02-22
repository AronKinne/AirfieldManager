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
    if (currentMenu == null) {
      for (Interactable i : interactables) i.mousePressed();
    } else {
      if (!currentMenu.mousePressed()) currentMenu = null;
    }
  } else if (mouseButton == RIGHT) {
    println();
    for (Interactable i : interactables) {
      print(i.name + ": ");
      for (String s : i.states) print(s + " ");
      println();
    }
    println(getCoords(mouseX, mouseY));
  }
}
