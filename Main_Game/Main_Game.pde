// I create arrays for the position of everything graphical, so it takes up less space in my code
int[] circleOne = new int[4];
int[] circleTwo = new int[4];
int[] dialogueBox = new int[4];
int[] enemyPokemonPosition = new int[2];
int[] allyPokemonPosition = new int[2];
int[] enemyHealthBar = new int[6];
int[] allyHealthBar = new int[6];

// Sprites for the pokemon
PImage enemyPokemonSprite;
PImage allyPokemonSprite;

// Instantiating two pokemon, one for enemy and one for ally.
Pokemon enemyPokemon, allyPokemon; 

int accuracyAndEvasion = 100; // As accuracy and evasion both start at 100, I give them a shared variable.

// HP, atk, def, spAtk, spDef, Accuracy, Evasion, Speed
int[] enemyPokemonStats = {80, 50, 80, 20, 65, accuracyAndEvasion, accuracyAndEvasion, 40};
int[] allyPokemonStats = {50, 70, 50, 40, 55, accuracyAndEvasion, accuracyAndEvasion, 60};

int circleSizeX;
int circleSizeY;
int spriteSize = 128;

int dialogueBoxSize = 87;
int healthBarW;
int allyHealthBarH = 56;
int enemyHealthBarH = allyHealthBarH - 8;
int healthBarCurve = 8;

void setup() {
  size(512, 384); //Size is the same as the size of a nintendo Screen.
  rectMode(CENTER);
  imageMode(CENTER);

  visualVariables();

  generatePokemon();
}

void draw() {
  bg();
}

void visualVariables() {
  enemyPokemonSprite = loadImage("bulbasaur.png");
  enemyPokemonSprite.resize(spriteSize, spriteSize);
  allyPokemonSprite = loadImage("bulbasaurBehind.png");
  allyPokemonSprite.resize(spriteSize, spriteSize);

  circleSizeX = width/2;
  circleSizeY = height/5;

  circleOne[0] = width/2+width/5;
  circleOne[1] = height/2-circleSizeY;
  circleOne[2] = circleSizeX;
  circleOne[3] = circleSizeY;

  circleTwo[0] = width/2-width/5;
  circleTwo[1] = height-circleSizeY;
  circleTwo[2] = circleSizeX;
  circleTwo[3] = circleSizeY;

  dialogueBox[0] = width/2;
  dialogueBox[1] = height-dialogueBoxSize/2;
  dialogueBox[2] = width+1;
  dialogueBox[3] = dialogueBoxSize;

  enemyPokemonPosition[0] = circleOne[0]; // X position the same as the corresponding circle
  enemyPokemonPosition[1] = circleOne[1] - spriteSize/3; // Position be offset by a third of the sprite size

  allyPokemonPosition[0] = circleTwo[0]; // X position the same as the corresponding circle
  allyPokemonPosition[1] = circleTwo[1] - spriteSize/3; 

  healthBarW = round(width/3.5); // Sets the width of the healthbar to be a fourth of the width of the screen

  enemyHealthBar[0] = circleTwo[0] - 48; // Makes the x position be the same as the enemy, so i can place it above it. With an offset
  enemyHealthBar[1] = circleOne[1] - 48; // Makes the y be the same as its own circle, with the same offset
  enemyHealthBar[2] = healthBarW; 
  enemyHealthBar[3] = enemyHealthBarH;
  enemyHealthBar[4] = healthBarCurve; // Adds a curve to the rectacle edges
  enemyHealthBar[5] = healthBarCurve/4; // Another variable to make one curve less curvier than the other

  allyHealthBar[0] = circleOne[0] + 48; // Makes the x position be the same as the enemy, so i can place it under it. With an offset
  allyHealthBar[1] = circleTwo[1] - 64; // Makes the y be the same as its own circle, with the same offset
  allyHealthBar[2] = healthBarW;
  allyHealthBar[3] = allyHealthBarH;
  allyHealthBar[4] = healthBarCurve;
  allyHealthBar[5] = healthBarCurve/4;
}

void generatePokemon() {
  enemyPokemon = new Pokemon("Wide Gade", "Normal", enemyPokemonStats, 5);
  allyPokemon = new Pokemon("Cowboy Hat Gade", "", "", allyPokemonStats, 5);
}

void bg() {
  background(230, 255, 255);

  fill(50, 255, 50);
  ellipse(circleOne[0], circleOne[1], circleOne[2], circleOne[3]);
  ellipse(circleTwo[0], circleTwo[1], circleTwo[2], circleTwo[3]);

  fill(0);
  rect(dialogueBox[0], dialogueBox[1], dialogueBox[2], dialogueBox[3]);

  image(enemyPokemonSprite, enemyPokemonPosition[0], enemyPokemonPosition[1]);

  image(allyPokemonSprite, allyPokemonPosition[0], allyPokemonPosition[1]);

  fill(255);
  rect(enemyHealthBar[0], enemyHealthBar[1], enemyHealthBar[2], enemyHealthBar[3], enemyHealthBar[4], enemyHealthBar[5], enemyHealthBar[4], enemyHealthBar[5]);

  rect(allyHealthBar[0], allyHealthBar[1], allyHealthBar[2], allyHealthBar[3], allyHealthBar[4], allyHealthBar[5], allyHealthBar[4], allyHealthBar[5]);
}
