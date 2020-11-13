// Instantiating two pokemon, one for enemy and one for ally.
Pokemon enemyPokemon, allyPokemon; 

// Instantiating the background
Battlefield battlefield;

int accuracyAndEvasion = 100; // As accuracy and evasion both start at 100, I give them a shared variable.

// HP, atk, def, spAtk, spDef, Accuracy, Evasion, Speed
int[] enemyPokemonStats = {80, 50, 80, 20, 65, accuracyAndEvasion, accuracyAndEvasion, 40};
int[] allyPokemonStats = {50, 70, 50, 40, 55, accuracyAndEvasion, accuracyAndEvasion, 60};

void setup() {
  size(512, 384); //Size is the same as the size of a nintendo Screen.
  rectMode(CENTER);
  imageMode(CENTER);
  
  battlefield = new Battlefield();

  battlefield.visualVariables();
  generatePokemon();
}

void draw() {
  battlefield.bg();
}

void generatePokemon() {
  enemyPokemon = new Pokemon("Wide Gade", "Normal", enemyPokemonStats, 5);
  allyPokemon = new Pokemon("Cowboy Hat Gade", "", "", allyPokemonStats, 5);
  
  Move move1 = new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1) ;
  
  allyPokemon.setMoves(move1,move1,move1,move1);
  allyPokemon.useAttack(move1.name);
}
