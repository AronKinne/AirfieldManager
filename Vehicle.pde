class Vehicle extends Interactable {

  Plane pulledPlane;
  PVector towPoint;
  float ropeLen;
  
  Vehicle(String name, String imgPath) {
    super(name, imgPath);

    pulledPlane = null;
    ropeLen = 15;
  }

  void draw() {
    super.draw();
    
    if(apron != null) checkApron();

    towPoint = PVector.add(pos, PVector.fromAngle(dir + HALF_PI).mult(h * .5));
  }

  private void checkApron() {
    if (visible && apron.detectCollision(pos.copy())) {
      addState("IN_APRON"); 
    } else {
      removeState("IN_APRON"); 
    }
  }  

  void setPulledPlane(Plane pp) {
    pulledPlane = pp;
  } 
}
