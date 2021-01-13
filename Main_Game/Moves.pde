class Move {

  // General for a move
  String name;
  String description;
  int powerPoint;
  String type; // Damage type
  String category; //Special, physical or status
  SoundFile file;

  // Damage and hitting
  int power;
  int accuracy;

  //Some moves are faster than others, so I have to make a variable to determine the speed of the move
  int speed;

  // Attack move constructor
  Move(String _name, String _description, int _power, int _accuracy, int _powerPoint, String _type, String _category, int _speed, SoundFile _file) {
    name = _name;
    description = _description;
    powerPoint = _powerPoint;
    file = _file;

    power = _power;
    accuracy = _accuracy;
    type = _type;
    category = _category;
    speed = _speed;
  }

  // Status move constructor
  Move(String _name, String _description, int _accuracy, int _powerPoint, String _type, int _speed) {
    name = _name;
    description = _description;

    accuracy = _accuracy;
    powerPoint = _powerPoint;
    type = _type;
    category = "Status";
    speed = _speed;
  }

  boolean checkToHit(int accuracyMove, float accuracy, float evasion) {
    float A = accuracyMove * (accuracy - evasion);
    float R = round(random(1, 100));

    if (R <= A) {
      return true;
    } else {
      return false;
    }
  }

  void playSound() {
    file.amp(0.4);
    file.play();
  }

  void physicalDamageToTarget(int level, float attack_user, Pokemon target) {
    float modifier = 1; //targets*weather*badge*critical*random*stab*type*burn*other;
    float physicalDamage = ((((2*level)/5+2)*power*(attack_user/target.pokemonStats[target.physicalDef]))/50+2)*modifier;
    target.newHealth -= physicalDamage;
  }

  void specialDamageToTarget(int level, float attack_user, Pokemon target) {
    float modifier = 1; //targets*weather*badge*critical*random*stab*type*burn*other;
    float specialDamage = ((((2*level)/5+2)*power*(attack_user/target.pokemonStats[target.specialDef]))/50+2)*modifier;
    target.newHealth -= specialDamage;
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
   int physicalDamage = ((((2*level)/5+2)*power*(attack_user/defense_target))/50+2)*modifier;
   float modifier = targets*weather*badge*critical*random*stab*type*burn*other;
   */
}
