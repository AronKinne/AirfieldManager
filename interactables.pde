Interactable hanger, kfzHalle;
Plane ask21;

void createInteractables() {

  hanger = new Interactable("Segelflugzeug-Halle", null);
  hanger.setBounds(1365, 44, 47, 20);
  hanger.setDir(.28);

  hanger.addMenuPoint("Segelflugzeug-Halle", "Flugzeuge");
  /**/  hanger.addMenuPoint("Flugzeuge", "ASK 21");
  /**/  hanger.addMenuPoint("Flugzeuge", "Twin");
  /**/  hanger.addMenuPoint("Flugzeuge", "Puchacz");
  /**/  hanger.addMenuPoint("Flugzeuge", "Bocian");
  /**/  hanger.addMenuPoint("Flugzeuge", "Astir 84");
  /**/  hanger.addMenuPoint("Flugzeuge", "Astir 01");
  /**/  hanger.addMenuPoint("Flugzeuge", "Pirat");

 
  kfzHalle = new Interactable("KFZ-Halle", null);
  kfzHalle.setBounds(1399, 54, 24, 20);
  kfzHalle.setDir(.28);

  kfzHalle.addMenuPoint("KFZ-Halle", "Fahrzeuge");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "SKP");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "Winde");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "T4");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "Omega");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "Focus");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "Escort");
  /**/  kfzHalle.addMenuPoint("Fahrzeuge", "Traktor");
  kfzHalle.addMenuPoint("KFZ-Halle", "Akkus");
  
  ask21 = new Plane("ASK 21");
  ask21.setBounds(1359, 79, 30, 10);
  ask21.setDir(radians(150));
  
}