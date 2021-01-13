class Pokemon {

  String pokemonName;
  String pokemonType1;
  String pokemonType2;

  ArrayList<Move> moveSet;

  // Stats that can be affected through combat
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

  float[] pokemonStats = new float[8];

  // Level || Just for actual visual and does not really get used.
  int level;
  int experiencePoints;

  // ______ 

  Pokemon(String _name, String _type1, float[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;

    arrayCopy(_stats, pokemonStats);
    currentHealth = round(_stats[healthPoints]);
    newHealth = round(_stats[healthPoints]);

    level = _level;
  }

  // ______ 

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

  void setMoves(Move move1, Move move2, Move move3, Move move4) {
    moveSet = new ArrayList<Move>();
    moveSet.add(move1); //new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1) 
    moveSet.add(move2); //new Move("Growl", "Lowers the targets attack", 100, 40, "Normal", 1)
    moveSet.add(move3); //new Move("","", , "",)
    moveSet.add(move4); //new Move("","", , "",)
  }

  // ______ 

  void useAttack(Move chosenMove, Pokemon target) {
    if (chosenMove.checkToHit(chosenMove.accuracy, pokemonStats[accuracy], target.pokemonStats[evasion]) == true) {
      if (chosenMove.category == "Status") {
        // Use status move
      } else if (chosenMove.category == "Physical") {
        chosenMove.physicalDamageToTarget(level, pokemonStats[physicalAtk], target); // Use physical move
        chosenMove.playSound();
        
        target.lowerHealth();
      } else if (chosenMove.category == "Special") {
        chosenMove.specialDamageToTarget(level, pokemonStats[specialAtk], target); // Use special move
        chosenMove.playSound();
        
        target.lowerHealth();
      } else {
        println("No category found. Cannot execute move.");
      }
    } else {
      println("Miss");
    }
  }
  
  // ______ 

  boolean checkFaint(Pokemon target) {
    if (target.newHealth <= 0) {
      target.newHealth = 0;
      return true;
    }
    return false;
  }
  
  // ______ 

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
