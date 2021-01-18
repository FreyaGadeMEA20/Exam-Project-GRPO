/*
Aalborg university in Copenhagen
 Medialogy - E20
 GRPO exam - 15.01.2021
 Lukas Gade Ravnsborg
 studyno. 20204013
 */

import processing.sound.*;

// Declaring two pokemon, one for enemy and one for ally.
Pokemon enemyPokemon, allyPokemon; 


// Declaring the moves, 4 for each Pokémon
Move move1, move2, move3, move4;
Move enemyMove1, enemyMove2, enemyMove3, enemyMove4;

Battlefield battlefield;
Battle battle;
SoundFile bgMusic;

// ______ 

void setup() {
  size(512, 384); //Size is the same as twice the size of a Nintendo DS screen.
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(12);
  frameRate(60);

  bgMusic = new SoundFile(this, "battleMusic.mp3");
  bgMusic.amp(0.05); // Loud music, so i turn it down
  bgMusic.loop(); // Keep it looped so if the user just leaves it will still play when they get back.

  // Generating everything important for the pokemon and the battlefield.
  battlefield = new Battlefield();
  battlefield.visualVariables();
  generatePokemon();
}

// ______ 

void draw() {

  // I constantly update the battlefield each frame.
  battlefield.bg();
  battlefield.allyPokemonHealth(round(allyPokemon.currentHealth), round(allyPokemon.pokemonStats[0]), allyPokemon.pokemonName, allyPokemon.level);
  battlefield.enemyPokemonHealth(round(enemyPokemon.currentHealth), round(enemyPokemon.pokemonStats[0]), enemyPokemon.pokemonName, enemyPokemon.level);
  battlefield.dialogueBox(allyPokemon);

  // Statement that runs if the booleans from the battlefield class are false, to decide what the state of the game is.
  if (!battlefield.chooseMove && !battlefield.gameFinished) {
    battle.battleTextWriter(battlefield);
  } 

  // End screen that runs if the boolean is true.
  if (battlefield.gameFinished) {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255);
    text(battle.winningText, width/2, height/2);
  }
}

// ______ 

// Function for generating both ally and enemy Pokémon
void generatePokemon() {
  // Levels for the Pokémon
  int allyPokemonLevel = 19;
  int enemyPokemonLevel = 16;

  // HP, atk, def, spAtk, spDef, Accuracy, Evasion, Speed.
  // Each are based in accordance with the stats of the Pokemon, taken from Bulbapedia (wiki for pokemon), and the level of the pokemon
  float[] enemyPokemonStats = {8+enemyPokemonLevel*2, 4+enemyPokemonLevel, 4+enemyPokemonLevel, 9+enemyPokemonLevel, 9+enemyPokemonLevel, 1, 0, 3+9+enemyPokemonLevel};
  float[] allyPokemonStats = {8+allyPokemonLevel*2, 4+allyPokemonLevel, 4+allyPokemonLevel, 9+allyPokemonLevel, 9+allyPokemonLevel, 1, 0, 3+9+allyPokemonLevel};

  // Strings for names of the pokemon and their moves.
  String allyPokemonName = "Bulbasaur";
  String enemyPokemonName = "Enemy Bulbasaur";
  String[] allyMoves = {"Tackle", "Razor Leaf", "Vine Whip", "Hyper Beam"};
  String[] enemyMoves = {"Tackle", "Razor Leaf", "Vine Whip", "Hyper Beam"}; 
  
  // Instantiate both the ally and enemy Pokémon based on their stats.
  allyPokemon = new Pokemon(allyPokemonName, "Grass", "Poison", allyPokemonStats, allyPokemonLevel);
  enemyPokemon = new Pokemon(enemyPokemonName, "Normal", enemyPokemonStats, enemyPokemonLevel); 

  // Loading all the 4 moves for the ally Pokémon
  move1 = new Move(allyMoves[0], "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1, new SoundFile(this, allyMoves[0] + ".mp3"));
  move2 = new Move(allyMoves[1], "Tackles the opponent", 55, 90, 25, "Grass", "Special", 1, new SoundFile(this, allyMoves[1] + ".mp3"));
  move3 = new Move(allyMoves[2], "", 45, 100, 25, "Grass", "Physical", 1, new SoundFile(this, allyMoves[2] + ".mp3"));
  move4 = new Move(allyMoves[3], "", 150, 50, 5, "Normal", "Special", 1, new SoundFile(this, allyMoves[3] + ".mp3"));  

  // Loading all the 4 moves for the enemy Pokémon
  enemyMove1 = new Move(enemyMoves[0], "Tackles the opponent", 40, 100, 35, "Normal", "Physical", 1, new SoundFile(this, enemyMoves[0] + ".mp3"));
  enemyMove2 = new Move(enemyMoves[1], "Tackles the opponent", 55, 90, 25, "Grass", "Special", 1, new SoundFile(this, enemyMoves[1] + ".mp3"));
  enemyMove3 = new Move(enemyMoves[2], "", 45, 100, 25, "Grass", "Physical", 1, new SoundFile(this, enemyMoves[2] + ".mp3"));
  enemyMove4 = new Move(enemyMoves[3], "", 150, 50, 5, "Normal", "Special", 1, new SoundFile(this, enemyMoves[3] + ".mp3"));  

  // Sets the generated pokemon moves to the instantiated moves above.
  allyPokemon.setMoves(move1, move2, move3, move4);
  enemyPokemon.setMoves(enemyMove1, enemyMove2, enemyMove3, enemyMove4);
}

// ______ 

// Event that checks if the user clicks.
void mousePressed() {
  // Statement that runs if the user has selected a move.
  if (battlefield.selectedAMove) {
    // Sets the booleans to false so the user cannot click more than once
    battlefield.selectedAMove = false;
    battlefield.chooseMove = false;

    // Instantiates and runs the battle.
    battle = new Battle(allyPokemon, enemyPokemon);
    battle.battleController(battlefield);
  }
}
