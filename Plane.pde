class Plane extends Interactable {
  
  Vehicle towCar;
  PVector towPoint;
 
  Plane(String name) {
    super(name, "data/images/plane.png");
    
    towCar = null;
  }
  
  void draw() {
    super.draw();
    
    towPoint = PVector.sub(pos, PVector.fromAngle(dir + HALF_PI).mult(h * .5));
    
    if(towCar != null) {
       line(towPoint.x, towPoint.y, towCar.towPoint.x, towCar.towPoint.y);
       followTowCar();
    }
  }
  
  void setTowCar(Vehicle tc) {
    towCar = tc;
  }
  
  void followTowCar() {
    if(PVector.dist(pos, towCar.pos) > towCar.ropeLen) {
      setDest(towCar.pos);
    } else {
      setDest(null); 
    }
  }
  
}
