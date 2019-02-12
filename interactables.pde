Interactable hanger, kfzHalle;
Plane ask21;

void addMenu(Interactable inter, String parentName, Object[] menu) {
  for (Object point : menu) {

    // Untermenu
    if (point instanceof JSONObject) {
      JSONObject jPoint = (JSONObject)point;
      String name = jPoint.getString("name");
      Object[] oMenu = toObjectArray(jPoint.getJSONArray("menu"));

      inter.addMenuPoint(parentName, name);
      addMenu(inter, name, oMenu);
    }

    // Unterpunkte
    if (point instanceof String) {      
      inter.addMenuPoint(parentName, point.toString());
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

void createInteractables(String folderPath) {
  File[] files = listFiles(folderPath + "/Interactable/");

  for (File f : files) {
    if (f.getAbsolutePath().endsWith(".json")) {
      Interactable inter = null;

      try {
        JSONObject jFile = loadJSONObject(f);
        String name = jFile.getString("name");
        String imgPath = jFile.getString("img");

        inter = new Interactable(name, imgPath);

        JSONObject jPos = jFile.getJSONObject("pos");
        inter.setBounds(jPos.getInt("x"), jPos.getInt("y"), jPos.getInt("w"), jPos.getInt("h"));
        inter.setDir(jPos.getFloat("d"));

        Object[] oMenu = toObjectArray(jFile.getJSONArray("menu"));
        addMenu(inter, name, oMenu);
      } 
      catch(Exception e) {
        if (interactables.contains(inter)) interactables.remove(inter);
        println("ERROR: Could not load file " + f.getPath());
      }
    }
  }

  /*
   ask21 = new Plane("ASK 21");
   ask21.setBounds(1359, 79, 30, 10);
   ask21.setDir(radians(150));
   */
}
