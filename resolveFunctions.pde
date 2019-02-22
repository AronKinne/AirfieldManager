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
    String func = jConclusion.getString("function");
    
    MethodRelay mr = new MethodRelay(this, func, Interactable.class);
    mr.execute(inter);
  }
}

void connectToPlane(Interactable inter) {
    println(inter.name, "connect");
}
