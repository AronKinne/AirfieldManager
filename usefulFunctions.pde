PVector getCoords(float x, float y) {
  float outX = -width * .5 / zoom + centerX + x / zoom;
  float outY = -height * .5 / zoom + centerY + y / zoom;
  return new PVector(outX, outY);
}

PVector getPixels(float x, float y) {
  float outX = width * .5 - centerX * zoom + x * zoom;
  float outY = height * .5 - centerY * zoom + y * zoom;
  return new PVector(outX, outY);
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
    fileList.addAll(Arrays.asList(listFiles(folderPath + "\\" + path)));
  }

  File[] files = new File[fileList.size()];
  for (int i = 0; i < files.length; i++) files[i] = fileList.get(i);
  return files;
}

Interactable getInteractable(String jsonPath) {
  Interactable inter = null;
  String path = jsonPath.replace("/", "\\");
  for (Interactable i : interactables) {
    if (i.jsonPath.equals(sketchPath("") + path)) {
      inter = i;
      break;
    }
  }
  return inter;
}

Interactable getInteractable(PVector coords) {
  Interactable inter = null;
  for (Interactable i : interactables) {
    if (i.detectCollision(coords.copy()) && i.visible) {
      inter = i;
      break;
    }
  }
  return inter;
}

boolean inRange(Interactable i1, Interactable i2) {
  Vehicle v = null;
  Plane p = null;
  Interactable i = null;
  
  if(i1 instanceof Vehicle) {
    v = (Vehicle)i1;
    if(i2 instanceof Plane) p = (Plane)i2;
    else i = i2;
  } else if(i2 instanceof Vehicle) {
    v = (Vehicle)i2;
    if(i1 instanceof Plane) p = (Plane)i1;
    else i = i1;
  } else {
    println("ERROR: Could not find Vehicle for inRange()");
    return false;
  }
  
  float dist = p != null ? PVector.dist(v.towPoint, p.towPoint) : PVector.dist(v.pos, i.pos);
  if(dist <= v.ropeLen) {
    return true; 
  } else {
    println("ERROR: Not in range, " + dist + " > " + v.ropeLen);
    return false;
  }
}
