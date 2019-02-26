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

  Interactable i = getInteractable(getCoords(mouse.x, mouse.y));

  if (i != inter && i instanceof Plane) {
    Plane p = (Plane)i;
    Vehicle v = (Vehicle)inter;
    
    if (p.isNoState("HAT_TOWCAR") && PVector.dist(v.towPoint, p.towPoint) <= v.ropeLen) {
      p.setTowCar(v);
      v.setPulledPlane(p);

      p.addState("HAT_TOWCAR");
      inter.addState("HAT_FLUGZEUG");

      println("Set " + p.towCar.name + " as towcar from " + p.name);
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

void accuInPlane(Interactable inter, PVector mouse) {
  println("Function: accuInPlane");
}

// JSON Executes
void removeConnection(Interactable inter) {
  println("Execute: removeConnection");

  if (inter instanceof Vehicle) {
    Vehicle v = (Vehicle)inter;

    if (v.isState("UNTERWEGS")) {
      v.pulledPlane.setDest(null);
      v.speed = v.initSpeed;
    }

    v.pulledPlane.towCar = null;
    v.pulledPlane.removeState("HAT_TOWCAR");
    v.removeState("HAT_FLUGZEUG");
    v.pulledPlane = null;
  } else if (inter instanceof Plane) {
    Plane p = (Plane)inter; 

    if (p.towCar.isState("UNTERWEGS")) {
      p.setDest(null);
      p.towCar.speed = p.towCar.initSpeed;
    }

    p.towCar.pulledPlane = null;
    p.towCar.removeState("HAT_FLUGZEUG");
    p.removeState("HAT_TOWCAR");
    p.towCar = null;
  }
}
