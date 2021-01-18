/*
In Pokémon, each Pokémon has different moves, which share common functionality.
So I create a class to have all the common functionality of a move, so I can easily
create each move.

In most cases each move is coded differently, so I would normally have to code each move as its own class.
In this project I focused on just getting the move functionally very beta and simple.
*/

class Move {

  // General variables for a move
  String name;
  String description;
  int powerPoint;
  String type; // Damage type
  String category; //Special, physical or status
  SoundFile file; // sound it plays

  // Damage and hitting
  int power;
  int accuracy;

  //Some moves are faster than others, so I have to make a variable to determine the speed of the move
  int speed;

  // ______ 

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

  // ______ 

  // Status move constructor - not used, but made by the off chance i decided to make a status move system.
  Move(String _name, String _description, int _accuracy, int _powerPoint, String _type, int _speed) {
    name = _name;
    description = _description;

    accuracy = _accuracy;
    powerPoint = _powerPoint;
    type = _type;
    category = "Status";
    speed = _speed;
  }

  // ______ 

  // Boolean function that returns either true or false, depending on if the move hit or not. The formula is taken from Pokémon, gen 3 and forward. Source: https://bulbapedia.bulbagarden.net/wiki/Accuracy
  boolean checkToHit(int accuracyMove, float accuracy, float evasion) {
    // First it calculates "A", which is just the accuracy of the move, timed by the accuracy of the user and the evasion of the target.
    float A = accuracyMove * (accuracy - evasion);

    //Then it calculates a random number between 1 and 100
    float R = round(random(1, 100));

    // Then it compares the two to decide if the move hits or not. Also taken from Pokemon. Source: https://bulbapedia.bulbagarden.net/wiki/Accuracy
    if (R <= A) {
      return true;
    } else {
      return false;
    }
  }

  // ______ 

  // playSound function to play the moves sound.
  void playSound() {
    file.amp(0.4);
    file.play();
  }

  // ______ 

  void damageToTarget(int level, float attack_user, float target_defense, Pokemon target) {


    // When calculating damage, there are a lot of modifiers to lower or higher the damage. As i wish to not spend too much time on this, and lots of the variables require a lot more functionality, i only use the random number variable.
    // Source: https://bulbapedia.bulbagarden.net/wiki/Damage
    float modifier = random(0.85, 1.01); //targets*weather*badge*critical*random*stab*type*burn*other;
    
    // For calculating the damage i take in a lot of different variables. A clearer image of how it is calculated can be found either in the data folder called damage.png or at the source of the equation. Source: https://bulbapedia.bulbagarden.net/wiki/Damage
    float damage = ((((2*level)/5+2)*power*(attack_user/target_defense))/50+2)*modifier;
    
    // Then it lowers the health of the target, equal to the damage dealt.
    target.newHealth-=damage;
  }
}
