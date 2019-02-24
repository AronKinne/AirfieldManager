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
    }
  }
  
  void setTowCar(Vehicle tc) {
    towCar = tc;
  }
  
}
