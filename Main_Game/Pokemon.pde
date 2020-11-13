class Pokemon {

  String pokemonName;
  String pokemonType1;
  String pokemonType2;

  ArrayList<Move> moveSet;

  // Stats that can be affected through combat
  int currentHealth;
  int healthPoints = 0;
  int physicalAtk = 1;
  int physicalDef = 2;
  int specialAtk = 3;
  int specialDef = 4;
  int accuracy = 5;
  int evasion = 6;
  int speed = 7;

  int[] pokemonStats = new int[8];



  // Level || Just for actual visual and does not really get used.
  int level;
  int experiencePoints;

  Pokemon(String _name, String _type1, int[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;

    arrayCopy(_stats, pokemonStats);

    level = _level;
  }

  Pokemon(String _name, String _type1, String _type2, int[] _stats, int _level) {
    pokemonName = _name;
    pokemonType1 = _type1;
    pokemonType2 = _type2;

    arrayCopy(_stats, pokemonStats);

    level = _level;
  }

  void start() {
    
  }
  
  void setMoves(Move move1, Move move2, Move move3, Move move4){
    moveSet = new ArrayList<Move>();
    moveSet.add(move1); //new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1) 
    moveSet.add(move2); //new Move("Growl", "Lowers the targets attack", 100, 40, "Normal", 1)
    moveSet.add(move3); //new Move("","", , "",)
    moveSet.add(move4); //new Move("","", , "",)
  }
  
  void useAttack(String move){
   println(move); 
  }
}
