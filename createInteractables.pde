void createInteractables(String folderPath) {
  File[] files = getFiles(folderPath, "/Interactable/", "/Plane/", "/Vehicle/");
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
        case "vehicle":
          inter = new Vehicle(name);
          inter.setImage(jFile.getString("img"));
          inter.speed = jFile.getFloat("speed");
          break;
        default:
          throw new RuntimeException();
        }

        inter.visible = jFile.getBoolean("show");

        String[] states = toStringArray(jFile.getJSONArray("states"));
        inter.addStates(states);

        if (jFile.getJSONObject("pos") != null) {
          JSONObject jPos = jFile.getJSONObject("pos");
          inter.setBounds(jPos.getInt("x"), jPos.getInt("y"), jPos.getInt("w"), jPos.getInt("h"));
          inter.setDirDeg(jPos.getFloat("d"));
        }
        
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

String[] toStringArray(JSONArray jArray) {
  Object[] oStates = toObjectArray(jArray);
  return Arrays.copyOf(oStates, oStates.length, String[].class);
}

File[] getFiles(String folderPath, String... underFolderPaths) {
  ArrayList<File> fileList = new ArrayList<File>();
  for (String path : underFolderPaths) {
    fileList.addAll(Arrays.asList(listFiles(folderPath + path)));
  }

  File[] files = new File[fileList.size()];
  for (int i = 0; i < files.length; i++) files[i] = fileList.get(i);
  return files;
}
