class Plane extends Interactable {

  Vehicle towCar;
  PVector towPoint;

  Plane(String name) {
    super(name, "data/images/plane.png");

    towCar = null;
  }

  void draw() {
    super.draw();
    
    if(apron != null) checkApron();

    towPoint = PVector.sub(pos, PVector.fromAngle(dir + HALF_PI).mult(h * .5));

    if (towCar != null) {
      line(towPoint.x, towPoint.y, towCar.towPoint.x, towCar.towPoint.y);
      followTowCar();
    }
  }

  void setTowCar(Vehicle tc) {
    towCar = tc;
  }

  private void checkApron() {
    if (visible && apron.detectCollision(pos.copy())) {
      addState("IN_APRON"); 
    } else {
      removeState("IN_APRON"); 
    }
  }  

  void followTowCar() {
    if (PVector.dist(towPoint, towCar.towPoint) > towCar.ropeLen) {
      setDest(towCar.towPoint);
    } else {
      setDest(null);
    }
  }
}
