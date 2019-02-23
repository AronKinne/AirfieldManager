class Vehicle extends Interactable {

  Plane pulledPlane;
  PVector towPoint;

  Vehicle(String name) {
    super(name);

    pulledPlane = null;
  }

  void draw() {
    super.draw();

    towPoint = PVector.add(new PVector(x, y), PVector.fromAngle(dir + HALF_PI).mult(h * .5));
  }

  void setPulledPlane(Plane pp) {
    pulledPlane = pp;
  }
}
