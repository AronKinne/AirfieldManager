class Vehicle extends Interactable {

  Plane pulledPlane;
  PVector towPoint;
  float ropeLen;
  
  Vehicle(String name) {
    super(name);

    pulledPlane = null;
    ropeLen = 30;
  }

  void draw() {
    super.draw();
    
    if(apron != null) checkApron();

    towPoint = PVector.add(pos, PVector.fromAngle(dir + HALF_PI).mult(h * .5));
  }
  
  void checkApron() {
    if(visible && apron.detectCollision(pos.copy())) {
       addState("IN_APRON");
       apron.addState("HAT_VEHICLE");
    } else {
       removeState("IN_APRON"); 
       apron.removeState("HAT_VEHICLE");
    }
  }

  void setPulledPlane(Plane pp) {
    pulledPlane = pp;
  } 
}
