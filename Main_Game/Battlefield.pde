/*
This class is where I draw all of the essential background elements,
 the pokemon, healthbars, and the dialogue box with the moves the user can choose.
 
 It only has a few interactable elements, which are the moves the user can choose.
*/

class Battlefield {
  // Variables for background
  color backgroundColor = #E6FFFF;
  color minMappedColor = 180;
  int strokeOffset = 10;

  // Variables for the platforms the pokemon are standing on.
  int circleSizeX;
  int circleSizeY;
  color platformColor = #32FF32;

  // Variable for the size of the sprite, resized to fit.
  int spriteSize = 128;

  // Variables for the dialogue box and health bar
  int dialogueBoxSize = 87;
  int pokemonBoxW;
  int allyPokemonBoxH = 48;
  int enemyPokemonBoxH = allyPokemonBoxH/2+4;
  int pokemonBoxCurve = 8;
  int healthBarHeight = 8;
  color maxColor = 255;
  color minColor = 0;
  color healthBarState1 = #00ff00;
  color healthBarState2 = #ffff00;
  color healthBarState3 = #ff0000;

  // I create arrays for the position of everything graphical, so it takes up less space, in terms of lines, in my code
  int[] circleOne = new int[4];
  int[] circleTwo = new int[4];
  int[] dialogueBox = new int[4];
  int[] enemyPokemonPosition = new int[2];
  int[] allyPokemonPosition = new int[2];
  int[] enemyHealthBar = new int[6];
  int[] allyHealthBar = new int[6];

  // Variables for healthBar
  int circleTwoOffset = 64;
  int circleOneOffset = 48;

  // Sprites for the pokemon
  PImage enemyPokemonSprite;
  PImage allyPokemonSprite;

  // Boolean to control if the user is picking a move.
  boolean chooseMove = true;

  // Variables for the moves
  color move1Color = 180, move2Color = #00FF00, move3Color = #00FF00, move4Color = 180; // Future each move should have its own color
  int selectedMove;
  boolean moveSelected;
  boolean selectedAMove;

  // Boolean to check if the game is over or not.
  boolean gameFinished = false;

  // ______ 

  // Loads and instantiates every relevant variable and image. 
  void visualVariables() {
    // Images loading and resizing
    enemyPokemonSprite = loadImage("bulbasaur.png");
    enemyPokemonSprite.resize(spriteSize, spriteSize);
    allyPokemonSprite = loadImage("bulbasaurBehind.png");
    allyPokemonSprite.resize(spriteSize, spriteSize);

    // Size of the platform
    circleSizeX = width/2;
    circleSizeY = height/5;

    // Position of the platforms
    circleOne = new int[]{width/2+width/5, height/2-circleSizeY, circleSizeX, circleSizeY};
    circleTwo = new int[]{width/2-width/5, height-circleSizeY, circleSizeX, circleSizeY};

    // X position the same as the corresponding circle
    // Y position is offset by a third of the sprite size
    enemyPokemonPosition = new int[]{circleOne[0], circleOne[1] - spriteSize/3};
    allyPokemonPosition = new int[]{circleTwo[0], circleTwo[1]-spriteSize/3};

    // Dialogue box variables
    dialogueBox = new int[]{width/2, height-dialogueBoxSize/2, width, dialogueBoxSize};

    pokemonBoxW = round(width/3.5); // Sets the width of the healthbar to be a fourth of the width of the screen

    // Makes the x position be the same as the enemy, so i can place it above it. With an offset
    // Makes the y be the same as its own circle, with the same offset
    // Adds a curve to the rectacle edges
    // Another variable to make one curve less curvier than the other
    enemyHealthBar = new int[]{circleTwo[0] - circleTwoOffset, circleOne[1] - circleOneOffset, pokemonBoxW, enemyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
    allyHealthBar = new int[]{circleOne[0] + circleOneOffset, circleTwo[1] - circleTwoOffset, pokemonBoxW, allyPokemonBoxH, pokemonBoxCurve, pokemonBoxCurve/4};
  }

  // ______ 

  void bg() {
    //Background
    background(backgroundColor);

    // Draws the background lines for effect
    strokeWeight(strokeOffset-1); // Sets the stroke weight to 9, for chonky lines. One smaller than the distance between lines, for a nice effect with the background.
    for (int i = 0; i < height; i = i+strokeOffset) {
      float mappedColor = map(i, 0, height, minMappedColor, maxColor); // Remaps the value i, which is a large number from 0 to height, to a smaller number, in the color 0-255 range, as 255 is the max number in an 8-digit binary number, which colored are stored in.
      stroke(mappedColor, maxColor, maxColor); // Changes the red color in the stroke equal to the mapped color
      line(0, i, width, i); // draws a line for each time it runs the for loop
    }
    // Resets it to what it was previously
    strokeWeight(minColor+1);
    stroke(minColor);

    // Drawing the ellipse
    fill(platformColor);
    ellipse(circleOne[0], circleOne[1], circleOne[2], circleOne[3]);
    ellipse(circleTwo[0], circleTwo[1], circleTwo[2], circleTwo[3]);

    // Draws the Pokémon
    image(enemyPokemonSprite, enemyPokemonPosition[0], enemyPokemonPosition[1]);
    image(allyPokemonSprite, allyPokemonPosition[0], allyPokemonPosition[1]);

    // Draws the healthBars
    fill(maxColor);
    rect(enemyHealthBar[0], enemyHealthBar[1], enemyHealthBar[2], enemyHealthBar[3], enemyHealthBar[4], enemyHealthBar[5], enemyHealthBar[4], enemyHealthBar[5]);
    rect(allyHealthBar[0], allyHealthBar[1], allyHealthBar[2], allyHealthBar[3], allyHealthBar[4], allyHealthBar[5], allyHealthBar[4], allyHealthBar[5]);

    // Draws the dialogueBox
    fill(minColor);
    rect(dialogueBox[0], dialogueBox[1], dialogueBox[2], dialogueBox[3]);
  }

  // ______ 

  // function for drawing everything inside the dialogueBox
  void dialogueBox(Pokemon pokemon) {
    // Draws a white box inside the already generated dialogue box
    fill(maxColor);

    // Variables for offsetting the inner white box
    int offset = 4;
    int curve = 8;
    // Draws a similar dialogue box, but smaller
    rect(dialogueBox[0], dialogueBox[1], dialogueBox[2]-offset, dialogueBox[3]-offset, curve, curve, curve, curve);

    // Checks if the user is able to choose a move, before drawing the moves.
    if (chooseMove) {

      // Draws a line, which was supposed to have text on ther other side of it, but was missed.
      line(dialogueBox[0]*1.6, dialogueBox[1]-(dialogueBox[3]/2), dialogueBox[0]*1.6, dialogueBox[1]+dialogueBox[3]*2);

      // Moves
      // Variable for offsetting them
      int yOffset = 20;

      // Generates 4 boolean moves, which each draw their own dialogue box with the drawMove function.
      boolean move1 = drawMove(dialogueBox[0]-(dialogueBox[2]/3.5), dialogueBox[1]-yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 1, move1Color);
      boolean move2 = drawMove(dialogueBox[0]+(dialogueBox[2]/10), dialogueBox[1]-yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 2, move2Color);
      boolean move3 = drawMove(dialogueBox[0]-(dialogueBox[2]/3.5), dialogueBox[1]+yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 3, move3Color);
      boolean move4 = drawMove(dialogueBox[0]+(dialogueBox[2]/10), dialogueBox[1]+yOffset, dialogueBox[2]/3, dialogueBox[3]/2.5, curve, pokemon, 4, move4Color);

      // If any of the above booleans are set to true, which means the user is hovering over a move, it will let them select a move. Also changes the mouse to make it more obvious.
      if (move1 || move2 || move3 || move4) {
        cursor(HAND);
        selectedAMove = true;
      } else { // Else they cannot select a move.
        cursor(ARROW);
        selectedAMove = false;
      }
    }
  }

  // ______ 

  // Function for drawing an interactable button / move, that takes in everything it needs to know in order to draw the move.
  boolean drawMove(float x, float y, float w, float h, float curve, Pokemon pokemon, int moveName, color moveColor) {
    // Sets the color according to what the specified move color was
    color baseColor = moveColor;

    // Sets the condition areas of the move according to the positions it was given.
    boolean mouseCondition1 = mouseX > x - (w/2);
    boolean mouseCondition2 = mouseX < x + (w/2);
    boolean mouseCondition3 = mouseY > y - (h/2);
    boolean mouseCondition4 = mouseY < y + (h/2);

    // Checks if the cursor is within that specific button
    if (mouseCondition1 && mouseCondition2 && mouseCondition3 && mouseCondition4) {
      moveColor = moveColor - 60; // changes the color to a darker version
      moveSelected = true; // Sets the boolean that checks if the user has hovered over a button to true
      selectedMove = moveName; // Tells the program which move has been selected
    } else { // Makes sure the above is reversed when the mouse is off a move. SelectedMove only matters when clicked, and changes at every button.
      moveColor = baseColor;
      moveSelected = false;
    }

    // Draws the move
    fill(moveColor);
    rect(x, y, w, h, curve, curve, curve, curve);
    fill(minColor);
    textAlign(CENTER, CENTER);
    text(pokemon.moveSet.get(moveName-1).name, x, y);
    
    // Returns that the current move being selected is true, so the program knows it can click on a move.
    return moveSelected;
  }

  // ______ 

  // Drawing the healthBar, name and level of the enemy Pokemon
  void enemyPokemonHealth(int currentHealth, int maxHealth, String name, int level) {
    rectMode(CORNER); // As I have elements that function better in the corner, I set the rect mode to corner.

    fill(minColor);
    // Text of the pokemon
    textAlign(LEFT); // As the name starts from the left side, I write it out from the left side with textAlign
    text(name, enemyHealthBar[0]/3-8, enemyHealthBar[1]-2);
    textAlign(RIGHT); // As the level is the opposite of the name, I set the textALign to be from the right side instead
    text("lv:"+level, enemyHealthBar[0]*1.5+28, enemyHealthBar[1]-2);

    // Slider for the health value
    // Color changes based on what part of the healthbar it has reached. Changes at half and at one fourth.
    float healthStatus = map(currentHealth, 0, maxHealth, 0, enemyHealthBar[2]/2);
    if (healthStatus >= (enemyHealthBar[2]/2)/2){
      fill(healthBarState1); 
    } else if (healthStatus >= (enemyHealthBar[2]/2)/4){
      fill(healthBarState2); 
    } else {
      fill(healthBarState3);
    }  
    // Drawing the health bar slider. Width is based on the healthStatus float, which is mapped down from its current health to the size of the healthBar.
    rect(enemyHealthBar[0] - healthBarHeight*2+6, enemyHealthBar[1] - healthBarHeight+10, healthStatus, healthBarHeight, 3, 3, 3, 3);

    // Outer rim of the health value
    noFill();
    rect(enemyHealthBar[0] - healthBarHeight*2+6, enemyHealthBar[1] - healthBarHeight+10, enemyHealthBar[2]/2, healthBarHeight, 3, 3, 3, 3);

    rectMode(CENTER); // resets the rectMode just to be safe.
  }

  // ______ 

  // Draws the healthBar, name, level and health of the ally pokemon
  void allyPokemonHealth(int currentHealth, int maxHealth, String name, int level) {
    rectMode(CORNER); // As I have elements that function better in the corner, I set the rect mode to corner.

    fill(minColor);
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
    // Color changes based on what part of the healthbar it has reached. Changes at half and at one fourth.
    float healthStatus = map(currentHealth, 0, maxHealth, 0, allyHealthBar[2]/2);
    if (healthStatus >= (allyHealthBar[2]/2)/2){
      fill(healthBarState1); 
    } else if (healthStatus >= (allyHealthBar[2]/2)/4){
      fill(healthBarState2); 
    } else {
      fill(healthBarState3);
    }
    // Drawing the health bar slider. Width is based on the healthStatus float, which is mapped down from its current health to the size of the healthBar.
    rect(allyHealthBar[0] - healthBarHeight*2+6, allyHealthBar[1] - healthBarHeight + 4, healthStatus, healthBarHeight, 3, 3, 3, 3);

    // Outer rim of the health value
    noFill();
    rect(allyHealthBar[0] - healthBarHeight*2+6, allyHealthBar[1] - healthBarHeight + 4, allyHealthBar[2]/2, healthBarHeight, 3, 3, 3, 3);

    rectMode(CENTER); // resets the rectMode just to be safe.
  }
}
