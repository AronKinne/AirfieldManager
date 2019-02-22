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
        boolean useStates = true, useNoStates = true;

        // states
        if (jCondition.getJSONArray("states") != null) {
          String[] states = toStringArray(jCondition.getJSONArray("states"));
          int existingStates = 0;

          for (String strSta : states) {
            if (reference.states.contains(strSta)) {
              existingStates++;
            }
          }

          useStates = existingStates == states.length;
        }
        
        // noStates
        if (jCondition.getJSONArray("noStates") != null) {
          String[] states = toStringArray(jCondition.getJSONArray("noStates"));
          int existingStates = 0;

          for (String strSta : states) {
            if (reference.states.contains(strSta)) {
              existingStates++;
            }
          }

          useStates = existingStates == 0;
        }

        usable = useStates && useNoStates;
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
          
          reference.addMenuFunction(parentMenu, name, jConclusion);
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
