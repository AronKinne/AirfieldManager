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

    towPoint = PVector.add(pos, PVector.fromAngle(dir + HALF_PI).mult(h * .5));
  }

  void setPulledPlane(Plane pp) {
    pulledPlane = pp;
  } 
}
