void addMenu(Interactable inter, Interactable reference, Menu parentMenu, Object[] menu) {
  for (Object point : menu) {

    // Object
    if (point instanceof JSONObject) {
      JSONObject jPoint = (JSONObject)point;
      String name = jPoint.getString("name");
      boolean usable = true;

      // Bedingung
      if (jPoint.getJSONObject("if") != null) {
        JSONObject jCondition =  jPoint.getJSONObject("if");
        usable = false;
        boolean useStates = true;

        // states
        if (jCondition.getJSONArray("states") != null) {
          Object[] oStates = toObjectArray(jCondition.getJSONArray("states"));
          String[] states = Arrays.copyOf(oStates, oStates.length, String[].class);
          int existingStates = 0;

          for (String strSta : states) {
            if (reference.states.contains(strSta)) {
              existingStates++;
            }
          }

          useStates = existingStates == states.length;
        }

        usable = useStates;
      }

      if (usable) {
        // Untermenu
        if (jPoint.getJSONArray("menu") != null) {
          Object[] oMenu = toObjectArray(jPoint.getJSONArray("menu"));

          Menu pm = inter.addMenuPoint(parentMenu, name);
          addMenu(inter, inter, pm, oMenu);
        }

        // Object-Verweis
        else if (jPoint.getString("object") != null) {
          JSONObject jObject = loadJSONObject(jPoint.getString("object"));
          Object[] oMenu = toObjectArray(jObject.getJSONArray("menu"));

          Interactable ref = null;
          String oPath = jPoint.getString("object").replace("/", "\\");
          for (Interactable i : interactables) {
            if (i.jsonPath.equals(sketchPath("") + oPath)) {
              ref = i;
              break;
            }
          }

          Menu pm = inter.addMenuPoint(parentMenu, name);
          if (ref != null)addMenu(inter, ref, pm, oMenu);
        }

        // Then
        else if (jPoint.getJSONObject("then") != null) {
          JSONObject jConclusion =  jPoint.getJSONObject("then");
          
          inter.addMenuFunction(parentMenu, name, jConclusion);
        }

        // Menupunkt
        else {
          inter.addMenuPoint(parentMenu, name);
        }
      }
    }

    // String
    if (point instanceof String) {
      inter.addMenuPoint(parentMenu, point.toString());
    }
  }
}
