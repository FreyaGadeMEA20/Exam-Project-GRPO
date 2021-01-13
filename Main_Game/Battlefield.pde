class Battlefield {
  int circleSizeX;
  int circleSizeY;
  int spriteSize = 128;

  int dialogueBoxSize = 87;
  int pokemonBoxW;
  int allyPokemonBoxH = 48;
  int enemyPokemonBoxH = allyPokemonBoxH/2+4;
  int pokemonBoxCurve = 8;
  int healthBarHeight = 8;

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

  boolean chooseMove = true;

  color move1Color = 180, move2Color = #00FF00, move3Color = #00FF00, move4Color = 180; // Future each move should have its own color
  int selectedMove;
  boolean moveSelected;
  boolean selectedAMove;
  boolean gameFinished = false;


  void visualVariables() {
    enemyPokemonSprite = loadImage("bulbasaur.png");
    enemyPokemonSprite.resize(spriteSize, spriteSize);
    allyPokemonSprite = loadImage("bulbasaurBehind.png");
    allyPokemonSprite.resize(spriteSize, spriteSize);

    circleSizeX = width/2;
    circleSizeY = height/5;

    circleOne = new int[]{width/2+width/5, height/2-circleSizeY, circleSizeX, circleSizeY};

    circleTwo = new int[]{width/2-width/5, height-circleSizeY, circleSizeX, circleSizeY};

    // X position the same as the corresponding circle
    // Y position is offset by a third of the sprite size
    enemyPokemonPosition = new int[]{circleOne[0], circleOne[1] - spriteSize/3};

    allyPokemonPosition = new int[]{circleTwo[0], circleTwo[1]-spriteSize/3};

    dialogueBox = new int[]{width/2, height-dialogueBoxSize/2, width, dialogueBoxSize};

    pokemonBoxW = round(width/3.5); // Sets the width of the healthbar to be a fourth of the width of the screen

    // Makes the x position be the same as the enemy, so i can place it above it. With an offset
    // Makes the y be the same as its own circle, with the same offset
    // Adds a curve to the rectacle edges
    // Another variable to make one curve less curvier than the other
    enemyHealthBar = new int[]{circleTwo[0] - 64, circleOne[1] - 48, pokemonBoxW, enemyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
    allyHealthBar = new int[]{circleOne[0] + 48, circleTwo[1] - 64, pokemonBoxW, allyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
  }

  void bg() {
    background(230, 255, 255);

    strokeWeight(9); // Sets the stroke weight to 9, for chonky lines
    for (int i = 0; i < height; i = i+10) {
      float mappedColor = map(i, 0, height, 100, 200); // Remaps the value i, which is a large number from 0 to height, to a smaller number, 0 to 230, which is the max number in an 8-digit binary number, which colored are stored in.
      stroke(mappedColor, 255, 255); // Changes the red color in the stroke equal to the mapped color
      line(0, i, width, i); // draws a line for each time it runs the for loop
    }
    // Resets it to what it was previously
    strokeWeight(1);
    stroke(0);

    fill(50, 255, 50);
    ellipse(circleOne[0], circleOne[1], circleOne[2], circleOne[3]);
    ellipse(circleTwo[0], circleTwo[1], circleTwo[2], circleTwo[3]);

    image(enemyPokemonSprite, enemyPokemonPosition[0], enemyPokemonPosition[1]);

    image(allyPokemonSprite, allyPokemonPosition[0], allyPokemonPosition[1]);

    fill(255);
    rect(enemyHealthBar[0], enemyHealthBar[1], enemyHealthBar[2], enemyHealthBar[3], enemyHealthBar[4], enemyHealthBar[5], enemyHealthBar[4], enemyHealthBar[5]);

    rect(allyHealthBar[0], allyHealthBar[1], allyHealthBar[2], allyHealthBar[3], allyHealthBar[4], allyHealthBar[5], allyHealthBar[4], allyHealthBar[5]);

    fill(0);
    rect(dialogueBox[0], dialogueBox[1], dialogueBox[2], dialogueBox[3]);
  }

  void dialogueBox(Pokemon pokemon) {
    color dialogueBoxColor = 255;
    fill(dialogueBoxColor);
    int offset = 4;
    int curve = 8;
    rect(dialogueBox[0], dialogueBox[1], dialogueBox[2]-offset, dialogueBox[3]-offset, curve, curve, curve, curve);

    if (chooseMove) {

      line(dialogueBox[0]*1.6, dialogueBox[1]-(dialogueBox[3]/2), dialogueBox[0]*1.6, dialogueBox[1]+dialogueBox[3]*2);
      // Moves
      int yOffset = 20;
      boolean move1 = drawMove(dialogueBox[0]-(dialogueBox[2]/3.5), dialogueBox[1]-yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 1, move1Color);
      boolean move2 = drawMove(dialogueBox[0]+(dialogueBox[2]/10), dialogueBox[1]-yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 2, move2Color);
      boolean move3 = drawMove(dialogueBox[0]-(dialogueBox[2]/3.5), dialogueBox[1]+yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 3, move3Color);
      boolean move4 = drawMove(dialogueBox[0]+(dialogueBox[2]/10), dialogueBox[1]+yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 4, move4Color);

      if (move1 || move2 || move3 || move4) {
        selectedAMove = true;
      } else {
        selectedAMove = false;
      }
    } else {
    }
  }

  boolean drawMove(float x, float y, float w, float h, float curve, Pokemon pokemon, int moveName, color moveColor) {
    color baseColor = moveColor;

    boolean mouseCondition1 = mouseX > x - (w/2);
    boolean mouseCondition2 = mouseX < x + (w/2);
    boolean mouseCondition3 = mouseY > y - (h/2);
    boolean mouseCondition4 = mouseY < y + (h/2);

    if (mouseCondition1 && mouseCondition2 && mouseCondition3 && mouseCondition4) {
      moveColor = moveColor - 60;
      moveSelected = true;
      selectedMove = moveName;
    } else {
      moveColor = baseColor;
      moveSelected = false;
    }

    fill(moveColor);
    rect(x, y, w, h, curve, curve, curve, curve);
    fill(0);
    textAlign(CENTER, CENTER);
    text(pokemon.moveSet.get(moveName-1).name, x, y);
    return moveSelected;
  }

  void enemyPokemonHealth(int currentHealth, int maxHealth, String name, int level) {
    rectMode(CORNER); // As I have elements that function better in the corner, I set the rect mode to corner.

    fill(0);
    // Text of the pokemon
    textAlign(LEFT); // As the name starts from the left side, I write it out from the left side with textAlign
    text(name, enemyHealthBar[0]/3-8, enemyHealthBar[1]-2);
    textAlign(RIGHT); // As the level is the opposite of the name, I set the textALign to be from the right side instead
    text("lv:"+level, enemyHealthBar[0]*1.5+28, enemyHealthBar[1]-2);

    // Slider for the health value
    fill(#ff0000);
    rect(enemyHealthBar[0] - healthBarHeight*2+6, enemyHealthBar[1] - healthBarHeight+10, map(currentHealth, 0, maxHealth, 0, enemyHealthBar[2]/2), healthBarHeight, 3, 3, 3, 3);

    // Outer rim of the health value
    noFill();
    rect(enemyHealthBar[0] - healthBarHeight*2+6, enemyHealthBar[1] - healthBarHeight+10, enemyHealthBar[2]/2, healthBarHeight, 3, 3, 3, 3);

    rectMode(CENTER);
  }

  void allyPokemonHealth(int currentHealth, int maxHealth, String name, int level) {
    rectMode(CORNER); // As I have elements that function better in the corner, I set the rect mode to corner.

    fill(0);
    // Text of the pokemon - name
    textAlign(LEFT); // As the name starts from the left side, I write it out from the left side with textAlign
    text(name, allyHealthBar[0]-(allyHealthBar[2]/2)+8, allyHealthBar[1]-(allyHealthBar[3]/2)+16);

    // Text of the pokemon - level
    textAlign(RIGHT); // As the level is the opposite of the name, I set the textALign to be from the right side instead
    text("lv:"+level, allyHealthBar[0]+(allyHealthBar[2]/2), allyHealthBar[1]-(allyHealthBar[3]/2) + 16);

    // Text of the pokemon - health
    textAlign(RIGHT, CENTER);
    text(currentHealth + "/" + maxHealth, allyHealthBar[0] + (allyHealthBar[2]/2), allyHealthBar[1] + allyHealthBar[3]/4);

    // Slider for the health value
    fill(#ff0000);
    rect(allyHealthBar[0] - healthBarHeight*2+6, allyHealthBar[1] - healthBarHeight + 4, map(currentHealth, 0, maxHealth, 0, allyHealthBar[2]/2), healthBarHeight, 3, 3, 3, 3);

    // Outer rim of the health value
    noFill();
    rect(allyHealthBar[0] - healthBarHeight*2+6, allyHealthBar[1] - healthBarHeight + 4, allyHealthBar[2]/2, healthBarHeight, 3, 3, 3, 3);

    rectMode(CENTER);
  }
}
