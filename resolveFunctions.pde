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
}

void connectToPlane(Interactable inter, PVector mouse) {
  println("Function: connectToPlane");
  
  for (Interactable i : interactables) {
    if (i != inter && i instanceof Plane) {
      if (i.visible && i.detectCollision(getCoords(mouse.x, mouse.y)) && !i.states.contains("HAT_TOWCAR")) {
        ((Plane)i).setTowCar((Vehicle)inter);
        ((Vehicle)inter).setPulledPlane((Plane)i);
        
        i.addState("HAT_TOWCAR");
        inter.addState("HAT_FLUGZEUG");
        
        println("Set " + ((Plane)i).towCar.name + " as towcar from " + i.name);
      }
    }
  }
}

void removeConnection(Interactable inter, PVector mouse) {
  println("Function: removeConnection");
  
  Vehicle v = (Vehicle)inter;
  
  v.pulledPlane.towCar = null;
  v.pulledPlane = null;
}
