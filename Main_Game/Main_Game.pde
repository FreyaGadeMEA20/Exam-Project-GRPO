// Instantiating two pokemon, one for enemy and one for ally.
Pokemon enemyPokemon, allyPokemon; 

// Instantiating the background
Battlefield battlefield;

Move move1, move2, move3, move4;

Battle battle;

int accuracyAndEvasion = 1; // As accuracy and evasion both start at 100, I give them a shared variable.

// HP, atk, def, spAtk, spDef, Accuracy, Evasion, Speed
float[] enemyPokemonStats = {40, 20, 20, 25, 25, 1, 0, 19};
float[] allyPokemonStats = {38, 19, 19, 24, 24, 1, 0, 18};

int allyPokemonLevel = 15;
int enemyPokemonLevel = 16;

String allyPokemonName = "Bulbasaur";
String enemyPokemonName = "Bulbasaur";

void setup() {
  size(512, 384); //Size is the same as twice the size of a Nintendo DS screen.
  rectMode(CENTER);
  imageMode(CENTER);



  battlefield = new Battlefield();

  battlefield.visualVariables();
  generatePokemon();
}

void draw() {

  // I constantly update the battlefield each frame.
  battlefield.bg();
  battlefield.allyPokemonHealth(round(allyPokemon.currentHealth), round(allyPokemon.pokemonStats[0]), allyPokemonName, allyPokemonLevel);
  battlefield.enemyPokemonHealth(round(enemyPokemon.currentHealth), round(enemyPokemon.pokemonStats[0]), enemyPokemonName, enemyPokemonLevel);
  battlefield.dialogueBox(allyPokemon);
  
  if (!battlefield.chooseMove){
    battle.battleTextWriter(battlefield);
  }
}

void generatePokemon() {
  enemyPokemon = new Pokemon(enemyPokemonName, "Normal", enemyPokemonStats, enemyPokemonLevel);
  allyPokemon = new Pokemon(allyPokemonName, "five", "five", allyPokemonStats, allyPokemonLevel);

  Move move1 = new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1);
  Move move2 = new Move("Razor Leaf", "Tackles the opponent", 55, 90, 25, "Grass", "Special", 1);

  allyPokemon.setMoves(move1, move2, move1, move1);
  enemyPokemon.setMoves(move1, move2, move1, move1);
}

void mousePressed() {
  if (battlefield.selectedAMove) {
    battlefield.chooseMove = false;
    battle = new Battle(allyPokemon, enemyPokemon);
    battle.battleController(battlefield);
    
  }
  //allyPokemon.useAttack(1, enemyPokemon);
}
