class Move {
  
  // General for a move
  String name;
  String description;
  int powerPoint;
  String type; // Damage type
  String category; //Special, physical or status
  
  // Damage and hitting
  int power;
  float accuracy;
  
  
  //Some moves are faster than others, so I have to make a variable to determine the speed of the move
  int speed;
  
  
  
  // Attack
  Move(String _name, String _description, int _power, float _accuracy, int _powerPoint, String _type, String _category, int _speed){
    name = _name;
    description = _description;
    powerPoint = _powerPoint;
    
    power = _power;
    accuracy = _accuracy;
    type = _type;
    category = _category;
    speed = _speed;  
  }
  
  // Status
  Move(String _name, String _description, float _accuracy, int _powerPoint, String _type, int _speed){
    name = _name;
    description = _description;
    
    accuracy = _accuracy;
    powerPoint = _powerPoint;
    type = _type;
    category = "Status";
    speed = _speed;  
  }
  
  /* Accuracy to hit formula (taken from bulbapedia, official pokemon encyclopedia) 
  int A = accuracy_move * (evasion_target - accuracy_user);
  int R = round(random(1, 100));
  if (R <= A){
   hit 
  } else {
   miss 
  }
  */
  
  /* Damage formula
  int physicalDamage = ((((2*level)/5+2)*power*attack_user/defense_target)/50+2)*modifier;
  float modifier = targets*weather*badge*critical*random*stab*type*burn*other;
  */
  
}