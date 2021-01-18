/*
Class for handling the battle system
 - Battle order
 - Usage of moves
 - Displaying text
*/
class Battle {
  // Variables for speed
  int allySpeed;
  int enemySpeed;
  int speedOrder;
  float rand;

  // Array of string for the text that gets shown in battle.
  String[] text;

  // Variables for type writer text effect
  int counter;
  int textNumber = 0;
  int textOffset = 20;

  // Variables for controlling the flow of the text
  int delay = 180;
  int setDelay = 180;
  boolean moveDelay = false;
  boolean firstText = true;
  boolean secondText = false;
  boolean thirdText = false;

  // Variables for end screen and for triggering it
  boolean gameFinished = false;
  String winningText = "";

  // Variables for checking if the Pokemon its attack or not.
  boolean missed = false;
  float counterForMiss;

  // Variables for the Pokémon and their moves
  Pokemon ally, enemy;
  Move chosenMove, randomEnemyMove;

  // Constructor that takes in the already loaded Pokémon, so it does not have to load them again.
  Battle(Pokemon _ally, Pokemon _enemy) {
    ally = _ally;
    enemy = _enemy;
  }

  // ______ 

  // Function that controls what pokemon goes first
  void battleController(Battlefield battlefield) {
    calculateFastestMove(battlefield.selectedMove, round(random(1, 4))); // Takes in the users selected move, as well as a random move from the enemy Pokémon, then decides which moves goes first.
    battleOrder(); // Runs the battle function
  }

  // ______ 

  // Function for calculating which goes first.
  void calculateFastestMove(int allyMove, int enemyMove) {
    chosenMove = ally.moveSet.get(allyMove-1); // Gets the chosen move of the user
    randomEnemyMove = enemy.moveSet.get(enemyMove-1); // Gets the random move of the enemy

    // Calculates the speed of the moves
    allySpeed = round(ally.pokemonStats[ally.speed]) * chosenMove.speed;
    enemySpeed = round(enemy.pokemonStats[enemy.speed]) * randomEnemyMove.speed;

    // Decides which goes first by changing the speedOrder variable which it will use later.
    if (allySpeed > enemySpeed) {
      speedOrder = 1;
    } else if (allySpeed < enemySpeed) {
      speedOrder = 2;
    } else if (allySpeed == enemySpeed) {
      speedOrder = 3;
    }
  }

  // ______ 

  // To simulate the course of the battle, i create a function that takes in which move is fastest, and then orders the combat from fastest to slowest.
  void battleOrder() {
    // Generates the string for the ally and enemy attack by using their names and their chosen move.
    String allyAttack = "The ally " + ally.pokemonName + " used " + chosenMove.name;
    String enemyAttack = "The foe " + enemy.pokemonName + " used " + randomEnemyMove.name;
    String faintMessage = ""; // 3rd message which is sometimes empty, sometimes not. Depends on if a pokemon fainted or not.

    // Sets up a text order string array depending on which pokemon went first.
    if (speedOrder == 1) {
      text = new String[]{allyAttack, enemyAttack, faintMessage};
    } else if (speedOrder == 2) {
      text = new String[]{enemyAttack, allyAttack, faintMessage};

      // In the off chance that both pokemon are tied in speed, i simulate a coinflip with random to just randomly choose which one goes first.
    } else if (speedOrder == 3) {
      rand = random(1);
      if (rand > 0.5) {
        text = new String[]{allyAttack, enemyAttack, faintMessage};
      } else {
        text = new String[]{enemyAttack, allyAttack, faintMessage};
      }
    }
  }

  // ______ 

  // Function for writing the text onto the battlefield.
  void battleTextWriter(Battlefield battlefield) {
    fill(0);
    textAlign(LEFT);

    // 3 statements that runs the text at which it has reached, by checking which boolean is true.
    if (firstText) {  
      // Checks if the counter is still smaller than the length of the text it is writing
      if (counter < text[textNumber].length()) {
        counter++; // If it is still small it makes the counter larger.
      } else if (counter >= text[textNumber].length()) { // if it has reached length of the text, this part will run
        // Once the text has run, it will check that moveDelay is false
        if (!moveDelay) {
          useAttack(); // It will then run the useAttack function
          moveDelay = true; // Then it will set moveDelay to true, so there is a bit of delay between it using the move and going to the next text
        }
        ownDelay(); // Runs the delay function

        // If the moveDelay is false again, which it goes when the delay above is over, this part will run
        if (!moveDelay) {
          // Variables controlling it is the next text to write
          firstText = false;
          if (!thirdText) { // If the opposite pokemon faints on the first turn, the thirdText will be turned true, so we check that that is not the case here
            secondText = true; // Which will then make it go to the second text
          }
          // Resets every variable important for writing the text.
          counter = 0;
          textNumber++;
          delay = setDelay;
        }
      }
      // Does the same as above, but instead with the second text.
    } else if (secondText)
    {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        if (!moveDelay) {
          useAttack();
          moveDelay = true;
        }

        ownDelay();

        if (!moveDelay) {
          // Variable to reset it to before moves
          secondText = false;
          thirdText = true;
          counter = 0;
          textNumber++;
          delay = setDelay;
        }
      }

      // For the third text there are a few exceptions, else practially identical with the above two
    } else if (thirdText) {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        if (!moveDelay) {
          useAttack();
          // In the third text there can be two different things it can show. Either nothing, or a faint text. 
          if (text[textNumber] != "") {
            // If it is nothing, it will not delay the program as to not leave empty text.
            moveDelay = true;
          }
        }

        // No delay like above, if the text is empty.
        if (text[textNumber] != "") {
          ownDelay();
        }

        if (!moveDelay) {
          // Checks if the game is finished, that one of the pokemon fainted or not, which it will then either go back to letting the user choose a move or go to end screen.
          if (!gameFinished) {
            battlefield.chooseMove = true;
          } else {
            battlefield.gameFinished = true;
          }
        }
      }
    }


    // Draws the text at the dialogueBox.
    text(text[textNumber].substring(0, counter), textOffset, battlefield.dialogueBox[1]-textOffset); // Position of text

    // Checks if the move missed or not, to decide if it needs to show that the move missed for the user.
    if (missed) { 
      // Checks that a counter is above0, which it then ticks down until it is zero
      if (counterForMiss > 0) {
        counterForMiss--;
      } else {
        missed = false; // If it is 0 or below, it will set the missed to false.
      }
      // Draws the text.
      textSize(map(counterForMiss, 0, 100, 32, 48));
      stroke(0);
      textAlign(CENTER, BOTTOM);
      text("Miss!", width/2, height/2);
      textSize(12);
    }
  }

  // ______

  // Handles the delay by counting it down if it is above 0, then sets it to false if it 0 or below.
  void ownDelay() {
    if (delay > 0) {
      delay--;
    } else {
      moveDelay = false;
    }
  }

  // ______

  // Missed function that sets all the variable relevant to their missed state.
  void missed() {
    if (!missed) {
      counterForMiss = 100;
      missed = true;
    }
  }

  // ______ 

  // Function that runs the Pokémon attack function, depending on the speedOrder, to decide which attacks first.
  void useAttack() {
    if (speedOrder == 1) {
      combat(ally, enemy);
    } else if (speedOrder == 2) {
      combat(enemy, ally);
    } else if (speedOrder == 3) { // if both are even in speed, it will randomly choose which goes first.
      if (rand > 0.5) {
        combat(ally, enemy);
      } else {
        combat(enemy, ally);
      }
    }
  }

  // ______ 

  // Function to decide the flow of the combat
  void combat(Pokemon first, Pokemon second) {
    // First it designates which pokemon move is which
    Move move1;
    Move move2;
    // it does this by checking if the pokemon First and the pokemon Ally are the same
    // Which it uses to designate the first move to correspond to the ally pokemon move and the second move to the enemy poemon move.
    if (first.pokemonName == ally.pokemonName) {
      move1 = chosenMove;
      move2 = randomEnemyMove;
      // Else it does the opposite
    } else {
      move1 = randomEnemyMove;
      move2 = chosenMove;
    }

    if (firstText) {
      first.useAttack(move1, second);
      otherCombatMessages(first, second, 1);
    } else if (secondText) {
      second.useAttack(move2, first);
      otherCombatMessages(second, first, 2);
    }
  }
  
  // ______
  
  // Function to run other combat messages, such as missing and fainting
  void otherCombatMessages(Pokemon user, Pokemon target, int turn) {
    // If the user missed, it will run the missed function
    if (user.missed) {
      missed();
    }
    // If the target pokemon has faitned, it will start showing the fainted message and then the final victory, or defeat, screen.
    if (user.checkFaint(target)) {
      if (turn == 1) {
        thirdText = true;
      }
      textNumber++;
      text[2] = target.pokemonName + " has fainted.";
      gameFinished = true;
      winningText = user.pokemonName + " is victorious!";
    }
  }

  /*void allyFirst() {
   if (firstText) { // If the boolean firstText is true, aka that it is in the first stage of the combat, it will run the first Pokémon attack and any other relevant combat messages.
   ally.useAttack(chosenMove, enemy);
   otherCombatMessages(ally, enemy, 1);
   } else if (secondText) { // If the secondText boolean is true, it will run the second Pokémon attack and its relevant combat messages.
   enemy.useAttack(randomEnemyMove, ally);
   otherCombatMessages(enemy, ally, 2);
   }
   }
   
   // ______ 
   
   // Does the same as above, but instead with 
   void enemyFirst() {
   if (firstText) {
   enemy.useAttack(randomEnemyMove, ally);
   otherCombatMessages(enemy, ally, 1);
   } else if (secondText) {
   ally.useAttack(chosenMove, enemy);
   otherCombatMessages(ally, enemy, 2);
   }
   }
   
   // ______ 
   
   void randomFirst() {
   if (rand > 0.5) {
   if (firstText) {
   ally.useAttack(chosenMove, enemy);
   otherCombatMessages(ally, enemy, 1);
   } else if (secondText) {
   enemy.useAttack(randomEnemyMove, ally);
   otherCombatMessages(enemy, ally, 2);
   }
   } else {
   if (firstText) {
   enemy.useAttack(randomEnemyMove, ally);
   otherCombatMessages(enemy, ally, 1);
   } else if (secondText) {
   ally.useAttack(chosenMove, enemy);
   otherCombatMessages(ally, enemy, 2);
   }
   }
   }*/

  // ______ 

}
