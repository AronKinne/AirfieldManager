void createInteractables(String folderPath) {
  File[] files = (File[])concat((Object)listFiles(folderPath + "/Interactable/"), (Object)listFiles(folderPath + "/Plane/"));
  println();

  for (File f : files) {
    if (f.getAbsolutePath().endsWith(".json")) {
      Interactable inter = null;

      try {
        JSONObject jFile = loadJSONObject(f);
        String name = jFile.getString("name");

        switch(jFile.getString("type").toLowerCase()) {
        case "interactable": 
          inter = new Interactable(name);
          inter.setImage(jFile.getString("img"));
          break;
        case "plane":
          inter = new Plane(name);
          break;
        default:
          throw new RuntimeException();
        }

        inter.visible = jFile.getBoolean("show");

        Object[] oStates = toObjectArray(jFile.getJSONArray("states"));
        String[] states = Arrays.copyOf(oStates, oStates.length, String[].class);
        inter.addStates(states);

        JSONObject jPos = jFile.getJSONObject("pos");
        inter.setBounds(jPos.getInt("x"), jPos.getInt("y"), jPos.getInt("w"), jPos.getInt("h"));
        inter.setDir(jPos.getFloat("d"));

        inter.jMenu = jFile.getJSONArray("menu");
        
        inter.jsonPath = f.getPath();
      } 
      catch(Exception e) {
        if (interactables.contains(inter)) interactables.remove(inter);
        println("ERROR: Could not load file " + f.getPath());
      }
    }
  }
}

Object[] toObjectArray(JSONArray jArray) {
  ArrayList<Object> list = new ArrayList<Object>(); 
  for (int i = 0; i < jArray.size(); i++) { 
    list.add(jArray.get(i));
  }

  Object[] out = new Object[list.size()];
  for (int i = 0; i < list.size(); i++) { 
    out[i] = list.get(i);
  }

  return out;
}