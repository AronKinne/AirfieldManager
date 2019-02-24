void resolve(Interactable inter, JSONObject jConclusion) {

  // remStates
  if (jConclusion.getJSONArray("remStates") != null) {
    inter.removeStates(toStringArray(jConclusion.getJSONArray("remStates")));
  }

  // addStates
  if (jConclusion.getJSONArray("addStates") != null) {
    inter.addStates(toStringArray(jConclusion.getJSONArray("addStates")));
  }

  // show
  if (jConclusion.get("show") != null) {
    inter.visible = jConclusion.getBoolean("show");
  }

  // pos
  if (jConclusion.getJSONObject("pos") != null) {
    JSONObject jPos = jConclusion.getJSONObject("pos");
    inter.setBounds(jPos.getInt("x"), jPos.getInt("y"), jPos.getInt("w"), jPos.getInt("h"));
    inter.setDirDeg(jPos.getFloat("d"));
  }

  // function
  if (jConclusion.getString("function") != null) {
    activeFunc = jConclusion.getString("function");
    activeInter = inter;
  }

  // exec
  if (jConclusion.getString("exec") != null) {
    MethodRelay mr = new MethodRelay(this, jConclusion.getString("exec"), Interactable.class);
    mr.execute(inter);
  }
}

// JSON Functions
void connectToPlane(Interactable inter, PVector mouse) {
  println("Function: connectToPlane");

  for (Interactable i : interactables) {
    if (i != inter && i instanceof Plane) {
      if (i.visible && i.detectCollision(getCoords(mouse.x, mouse.y)) && i.isNoState("HAT_TOWCAR") && PVector.dist(inter.pos, i.pos) <= ((Vehicle)inter).ropeLen) {
        ((Plane)i).setTowCar((Vehicle)inter);
        ((Vehicle)inter).setPulledPlane((Plane)i);

        i.addState("HAT_TOWCAR");
        inter.addState("HAT_FLUGZEUG");

        println("Set " + ((Plane)i).towCar.name + " as towcar from " + i.name);
      }
    }
  }
}

void goTo(Interactable inter, PVector mouse) {
  println("Function: goTo");

  if (inter instanceof Vehicle) {
    Vehicle v = (Vehicle)inter;

    if (v.isState("HAT_FLUGZEUG")) {
      Plane p = v.pulledPlane;
      
      if (p.isState("HAT_KULLER", "HAT_TOWCAR") && p.isNoState("IN_HANGAR")) {
        v.speed = p.initSpeed;
        v.setDest(getCoords(mouse.x, mouse.y));
      }
    } else {
      inter.setDest(getCoords(mouse.x, mouse.y));
    }
  }
}

// JSON Executes
void removeConnection(Interactable inter) {
  println("Execute: removeConnection");

  Vehicle v = (Vehicle)inter;

  v.pulledPlane.towCar = null;
  v.pulledPlane = null;
}
