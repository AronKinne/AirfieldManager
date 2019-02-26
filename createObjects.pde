void createInteractables(String folderPath) {
  File[] files = getFiles(folderPath, "static_objects", "planes", "vehicles");

  for (File f : files) {
    if (f.getAbsolutePath().endsWith(".json")) {
      Interactable inter = null;

      try {
        JSONObject jFile = loadJSONObject(f);
        String name = jFile.getString("name");

        switch(jFile.getString("type").toLowerCase()) {
        case "interactable": 
          inter = new Interactable(name, jFile.getString("img"));
          break;
        case "plane":
          inter = new Plane(name);
          break;
        case "vehicle":
          inter = new Vehicle(name, jFile.getString("img"));
          break;
        default:
          throw new RuntimeException();
        }

        inter.visible = jFile.getBoolean("show");

        if (jFile.get("speed") != null) inter.initSpeed(jFile.getFloat("speed"));

        String[] states = toStringArray(jFile.getJSONArray("states"));
        inter.addStates(states);

        if (jFile.getJSONObject("pos") != null) {
          JSONObject jPos = jFile.getJSONObject("pos");
          inter.setBounds(jPos.getInt("x"), jPos.getInt("y"), jPos.getInt("w"), jPos.getInt("h"));
          inter.setDirDeg(jPos.getFloat("d"));
        }

        inter.jMenu = jFile.getJSONArray("menu");

        inter.jsonPath = f.getPath();

        if (inter.isState("APRON")) apron = inter;
      } 
      catch(Exception e) {
        if (interactables.contains(inter)) interactables.remove(inter);
        println("ERROR: Could not load file " + f.getPath());
      }
    }
  }
}

void createCarryables(String folderPath) {
  File[] files = listFiles(folderPath);
}