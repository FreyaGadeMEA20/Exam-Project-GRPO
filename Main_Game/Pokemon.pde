class Pokemon {

  String pokemonName;
  String pokemonType1;
  String pokemonType2;

  ArrayList<Move> moveSet;

  // Stats that can be affected through combat
  int healthPoints = 0;
  int physicalAtk = 1;
  int physicalDef = 2;
  int specialAtk = 3;
  int specialDef = 4;
  int accuracy = 5;
  int evasion = 6;
  int speed = 7;

  int[] pokemonStats = new int[7];



  // Level || Just for actual visual and does not really get used.
  int level;
  int experiencePoints;

  Pokemon(String _name, String _type1, int[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;
    
    for (int i = 0; i > pokemonStats.length-1; i++) {
      pokemonStats[i] = _stats[i];
    }
    
    level = _level;
  }
  
    Pokemon(String _name, String _type1, String _type2, int[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;
    pokemonType2 = _type2;
    
    for (int i = 0; i > pokemonStats.length-1; i++) {
      pokemonStats[i] = _stats[i];
    }
    
    level = _level;
  }

  void start() {
    moveSet = new ArrayList<Move>();
    moveSet.add(new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1)); 
    moveSet.add(new Move("Growl", "Lowers the targets attack", 100, 40, "Normal", 1));
  }
}
