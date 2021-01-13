class Battle {
  int allySpeed;
  int enemySpeed;

  int speedOrder;
  float rand;
  String[] text;

  int counter;
  int textNumber = 0;
  int textOffset = 20;

  int delay = 180;
  int setDelay = 180;
  boolean moveDelay = false;
  boolean firstText = true;
  boolean secondText = false;
  boolean thirdText = false;

  boolean gameFinished = false;
  String winningText = "";

  boolean missed = false;
  float counterForMiss;

  Pokemon ally, enemy;

  Move chosenMove, randomEnemyMove;

  Battle(Pokemon _ally, Pokemon _enemy) {
    ally = _ally;
    enemy = _enemy;
  }

  // ______ 

  void battleController(Battlefield battlefield) {
    calculateFastestMove(battlefield.selectedMove, round(random(1, 4)));
    battleOrder();
  }

  // ______ 

  void calculateFastestMove(int allyMove, int enemyMove) {
    chosenMove = ally.moveSet.get(allyMove-1);
    randomEnemyMove = enemy.moveSet.get(enemyMove-1);
    allySpeed = round(ally.pokemonStats[ally.speed]) * chosenMove.speed;
    enemySpeed = round(enemy.pokemonStats[enemy.speed]) * randomEnemyMove.speed;

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
    String allyAttack = "The ally " + ally.pokemonName + " used " + chosenMove.name;
    String enemyAttack = "The foe " + enemy.pokemonName + " used " + randomEnemyMove.name;
    String faintMessage = "";

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

  void battleTextWriter(Battlefield battlefield) {
    fill(0);
    textAlign(LEFT);

    if (firstText) {  
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        if (!moveDelay) {
          useAttack();
          moveDelay = true;
        }
        ownDelay();

        if (!moveDelay) {
          // Variables controlling it is the next text to write
          firstText = false;
          if (!thirdText) {
            secondText = true;
          }
          counter = 0;
          textNumber++;
          delay = setDelay;
        }
      }
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
    } else if (thirdText) {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        if (!moveDelay) {
          useAttack();
          if (text[textNumber] != "") {
            moveDelay = true;
          }
        }

        if (text[textNumber] != "") {
          ownDelay();
        }

        if (!moveDelay) {
          // Variable to go back to picking moves
          if (!gameFinished) {
            battlefield.chooseMove = true;
          } else {
            battlefield.gameFinished = true;
          }
        }
      }
    }


    text(text[textNumber].substring(0, counter), textOffset, battlefield.dialogueBox[1]-textOffset); // Position of text

    if (missed) {
      if (counterForMiss > 0) {
        counterForMiss--;
      } else {
        missed = false;
      }
      textSize(map(counterForMiss, 0, 100, 32, 48));
      stroke(0);
      textAlign(CENTER, BOTTOM);
      text("Miss!", width/2, height/2);
      textSize(12);
    }
  }

  // ______

  void ownDelay() {
    if (delay > 0) {
      delay--;
    } else {
      moveDelay = false;
    }
  }

  // ______

  void missed() {
    if (!missed) {
      counterForMiss = 100;
      missed = true;
    } else if (missed) {
    }
  }

  // ______ 

  void useAttack() {
    if (speedOrder == 1) {
      allyFirst();
    } else if (speedOrder == 2) {
      enemyFirst();
    } else if (speedOrder == 3) {
      randomFirst();
    }
  }

  // ______ 

  void allyFirst() {
    if (firstText) {
      ally.useAttack(chosenMove, enemy);
      otherCombatMessages(ally, enemy, 1);
    } else if (secondText) {
      enemy.useAttack(randomEnemyMove, ally);
      otherCombatMessages(enemy, ally, 2);
    }
  }

  // ______ 

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
  }

  // ______ 

  void otherCombatMessages(Pokemon user, Pokemon target, int turn) {
    if (user.missed) {
      missed();
    }
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
}
