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
        usable = checkStates(reference, jCondition) && checkNoStates(reference, jCondition) && checkObject(jCondition);
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
          Interactable ref = getInteractable(jPoint.getString("object"));
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

// if states
boolean checkStates(Interactable inter, JSONObject jCondition) {
  if (jCondition.getJSONArray("states") != null) {
    String[] states = toStringArray(jCondition.getJSONArray("states"));
    
    return inter.isState(states);
  }

  return true;
}

// if noStates
boolean checkNoStates(Interactable inter, JSONObject jCondition) {
  if (jCondition.getJSONArray("noStates") != null) {
    String[] states = toStringArray(jCondition.getJSONArray("noStates"));
    
    return inter.isNoState(states);
  }

  return true;
}

// if object
boolean checkObject(JSONObject jCondition) {
  if (jCondition.getJSONObject("object") != null) {
    JSONObject jObject = jCondition.getJSONObject("object");
    Interactable ref = getInteractable(jObject.getString("path"));
    
    return checkStates(ref, jObject) && checkNoStates(ref, jObject);
  }
  
  return true;
}
