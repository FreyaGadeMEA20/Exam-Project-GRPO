import processing.sound.*;

// Instantiating two pokemon, one for enemy and one for ally.
Pokemon enemyPokemon, allyPokemon; 

// Instantiating the background
Battlefield battlefield;

Move move1, move2, move3, move4;

Battle battle;

int allyPokemonLevel = 19;
int enemyPokemonLevel = 16;

// HP, atk, def, spAtk, spDef, Accuracy, Evasion, Speed
float[] enemyPokemonStats = {8+enemyPokemonLevel*2, 4+enemyPokemonLevel, 4+enemyPokemonLevel, 9+enemyPokemonLevel, 9+enemyPokemonLevel, 1, 0, 3+9+enemyPokemonLevel};
float[] allyPokemonStats = {8+allyPokemonLevel*2, 4+allyPokemonLevel, 4+allyPokemonLevel, 9+allyPokemonLevel, 9+allyPokemonLevel, 1, 0, 3+9+allyPokemonLevel};

String allyPokemonName = "Bulbasaur";
String enemyPokemonName = "Enemy Bulbasaur";
String[] allyMoves = {"Tackle.mp3","Razor Leaf.mp3", "Vine Whip.mp3", "Hyper Beam.mp3"};

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

  if (!battlefield.chooseMove && !battlefield.gameFinished) {
    battle.battleTextWriter(battlefield);
  } 

  if (battlefield.gameFinished) {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255);
    text(battle.winningText, width/2, height/2);
  }
}

void generatePokemon() {
  enemyPokemon = new Pokemon(enemyPokemonName, "Normal", enemyPokemonStats, enemyPokemonLevel);
  allyPokemon = new Pokemon(allyPokemonName, "five", "five", allyPokemonStats, allyPokemonLevel);

  Move move1 = new Move("Tackle", "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1, new SoundFile(this, allyMoves[0]));
  Move move2 = new Move("Razor Leaf", "Tackles the opponent", 55, 90, 25, "Grass", "Special", 1, new SoundFile(this, allyMoves[1]));
  Move move3 = new Move("Vine Whip", "", 45, 100, 25, "Grass", "Physical", 1, new SoundFile(this, allyMoves[2]));
  Move move4 = new Move("Hyper Beam", "", 150, 50, 5, "Normal", "Special", 1, new SoundFile(this, allyMoves[3]));  

  allyPokemon.setMoves(move1, move2, move3, move4);
  enemyPokemon.setMoves(move1, move2, move3, move4);
}

void mousePressed() {
  if (battlefield.selectedAMove) {
    battlefield.selectedAMove = false;
    battlefield.chooseMove = false;
    battle = new Battle(allyPokemon, enemyPokemon);
    battle.battleController(battlefield);
  }
}
