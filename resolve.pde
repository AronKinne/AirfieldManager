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
  
  // connect
  if(jConclusion.getString("connect") != null) {
      memoryI = inter;
      memoryS = jConclusion.getString("connect");
  }
}
