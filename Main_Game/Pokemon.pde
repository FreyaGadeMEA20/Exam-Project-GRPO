/*
Each pokemon are the same, yet different. I give them common functionality here, so I
can easily create many Pokémon in no time.
*/

class Pokemon {

  // String variables for the name and level of the pokemon
  String pokemonName;
  String pokemonType1;
  String pokemonType2;

  // ArrayList of the moves the pokemon has.
  ArrayList<Move> moveSet;

  // Health variables. Two as I need to be able to change what it the number goes down to, if i were to animate the healthBar.
  int currentHealth;
  int newHealth;

  // Numbers for stat array, instead of having to remember all of the numbers
  int healthPoints = 0;
  int physicalAtk = 1;
  int physicalDef = 2;
  int specialAtk = 3;
  int specialDef = 4;
  int accuracy = 5;
  int evasion = 6;
  int speed = 7;
  
  // A float array for the stats.
  float[] pokemonStats = new float[8];

  // Level
  int level;
  //int experiencePoints;

  // Variable to check if the move missed or not
  boolean missed = false;

  // ______ 

  // Constructor for a pokemon with one typing
  Pokemon(String _name, String _type1, float[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;

    arrayCopy(_stats, pokemonStats); // Copying the array of the given stats.
    
    currentHealth = round(_stats[healthPoints]);
    newHealth = round(_stats[healthPoints]);

    level = _level;
  }

  // ______ 

  // Constructor for a pokemong with two typings
  Pokemon(String _name, String _type1, String _type2, float[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;
    pokemonType2 = _type2;

    arrayCopy(_stats, pokemonStats);
    currentHealth = round(_stats[healthPoints]);
    newHealth = round(_stats[healthPoints]);

    level = _level;
  }

  // ______ 

  // Function to add the moves given into the Pokémon move set.
  void setMoves(Move move1, Move move2, Move move3, Move move4) {
    moveSet = new ArrayList<Move>();
    moveSet.add(move1);
    moveSet.add(move2);
    moveSet.add(move3);
    moveSet.add(move4);
  }

  // ______ 

  // Function for the pokemon to use a given attack on a target Pokémon
  void useAttack(Move chosenMove, Pokemon target) {
    // First i check if the move hits by using the checkToHit function on the move.
    if (chosenMove.checkToHit(chosenMove.accuracy, pokemonStats[accuracy], target.pokemonStats[evasion]) == true) {
      // If it hits, it will then check what type of move it used and runs the moves damage function in order to deal damage to the target Pokémon.
      if (chosenMove.category == "Status") {
        // Use status move
      } else if (chosenMove.category == "Physical") {
        // Uses its damage move and then plays the sound
        chosenMove.damageToTarget(level, pokemonStats[physicalAtk], target.pokemonStats[target.physicalDef], target); // Use physical move
        chosenMove.playSound();
        
        // Then it runs the lowerHealth function to lower the health of the enemy pokemon.
        target.lowerHealth();
      } else if (chosenMove.category == "Special") {
        chosenMove.damageToTarget(level, pokemonStats[physicalAtk], target.pokemonStats[target.specialDef], target); // Use special move
        chosenMove.playSound();

        target.lowerHealth();
      } else {
        // This should never happen, and was mostly used under testing
        println("No category found. Cannot execute move.");
      }
    } else {
      // If it missed, it will set the missed boolean to true, which tells the program that the ability missed.
      missed = true;
    }
  }

  // ______ 

  // Checks if the pokemon has fainted or not, by checking if its hp is lower or equal to 0.
  boolean checkFaint(Pokemon target) {
    if (target.newHealth <= 0) {
      target.newHealth = 0;
      return true;
    }
    return false;
  }

  // ______ 

  // Lowers, or highers, the health of the pokemon depending on its newHealth and currentHealth variable.
  void lowerHealth() {
    if (newHealth <= 0) {
      newHealth = 0;
    }
    if (newHealth < currentHealth) {
      while (newHealth < currentHealth) {
        currentHealth--;
      }
    } else if (newHealth > currentHealth) {
      while (newHealth > currentHealth) {
        currentHealth--;
      }
    }
  }
}
