class Battlefield {
  int circleSizeX;
  int circleSizeY;
  int spriteSize = 128;

  int dialogueBoxSize = 87;
  int pokemonBoxW;
  int allyPokemonBoxH = 56;
  int enemyPokemonBoxH = allyPokemonBoxH - 8;
  int pokemonBoxCurve = 8;
  int healthBarHeight = 6;

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

  void visualVariables() {
    enemyPokemonSprite = loadImage("bulbasaur.png");
    enemyPokemonSprite.resize(spriteSize, spriteSize);
    allyPokemonSprite = loadImage("bulbasaurBehind.png");
    allyPokemonSprite.resize(spriteSize, spriteSize);

    circleSizeX = width/2;
    circleSizeY = height/5;

    circleOne = new int[]{width/2+width/5, height/2-circleSizeY, circleSizeX, circleSizeY};

    circleTwo = new int[]{width/2-width/5, height-circleSizeY, circleSizeX, circleSizeY};

    dialogueBox = new int[]{width/2, height-dialogueBoxSize/2, width, dialogueBoxSize};

    // X position the same as the corresponding circle
    // Y position is offset by a third of the sprite size
    enemyPokemonPosition = new int[]{circleOne[0], circleOne[1] - spriteSize/3};

    allyPokemonPosition = new int[]{circleTwo[0], circleTwo[1]-spriteSize/3};

    pokemonBoxW = round(width/3.5); // Sets the width of the healthbar to be a fourth of the width of the screen

    // Makes the x position be the same as the enemy, so i can place it above it. With an offset
    // Makes the y be the same as its own circle, with the same offset
    // Adds a curve to the rectacle edges
    // Another variable to make one curve less curvier than the other
    enemyHealthBar = new int[]{circleTwo[0] - 48, circleOne[1] - 48, pokemonBoxW, enemyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
    allyHealthBar = new int[]{circleOne[0] + 48, circleTwo[1] - 64, pokemonBoxW, allyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
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

  void enemyPokemon(int currentHealth, int maxHealth, String name, int level) {
    rectMode(CORNER);
    text(name, enemyHealthBar[0]-10, enemyHealthBar[1]-10);
    text(level, enemyHealthBar[0]-10, enemyHealthBar[1]+10);
    fill(#ff0000);
    rect(enemyHealthBar[0] - healthBarHeight*2, enemyHealthBar[1] - healthBarHeight/2, map(currentHealth, 0, maxHealth, 0, enemyHealthBar[2]/2), healthBarHeight);
    noFill();
    rect(enemyHealthBar[0] - healthBarHeight*2, enemyHealthBar[1] - healthBarHeight/2, enemyHealthBar[2]/2, healthBarHeight);
    rectMode(CENTER);
  }
}
