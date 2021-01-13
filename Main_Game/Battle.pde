class Battle {
  int allySpeed;
  int enemySpeed;

  int speedOrder;
  float rand;
  String[] text;

  int counter;
  int textNumber = 0;
  int textOffset = 20;

  boolean firstText = true;
  boolean secondText = false;
  boolean thirdText = false;

  boolean gameFinished = false;
  String winningText = "";

  Pokemon ally, enemy;

  Move chosenMove, randomEnemyMove;

  Battle(Pokemon _ally, Pokemon _enemy) {
    ally = _ally;
    enemy = _enemy;
  }

  void battleController(Battlefield battlefield) {
    calculateFastestMove(battlefield.selectedMove, round(random(1, 4)));
    battleOrder();
  }

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

  void battleTextWriter(Battlefield battlefield) {
    fill(0);
    textAlign(LEFT);

    if (firstText) {  
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        useAttack();
        delay(3000);

        // Variables controlling it is the next text to write
        firstText = false;
        if (!thirdText) {
          secondText = true;
        }
        counter = 0;
        textNumber++;
      }
    } else if (secondText)
    {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        useAttack();
        delay(3000);

        // Variable to reset it to before moves
        secondText = false;
        thirdText = true;
        counter = 0;
        textNumber++;
      }
    } else if (thirdText) {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        if (text[textNumber] != "") {
          delay(3000);
        }

        // Variable to go back to picking moves
        if (!gameFinished) {
          battlefield.chooseMove = true;
        } else {
          battlefield.gameFinished = true;
        }
      }
    }

    text(text[textNumber].substring(0, counter), textOffset, battlefield.dialogueBox[1]-textOffset); // Position of text
  }

  void useAttack() {
    if (speedOrder == 1) {
      allyFirst();
    } else if (speedOrder == 2) {
      enemyFirst();
    } else if (speedOrder == 3) {
      randomFirst();
    }
  }

  void allyFirst() {
    if (firstText) {
      ally.useAttack(chosenMove, enemy);
      checkFaint(ally, enemy, 1);
    } else {
      enemy.useAttack(randomEnemyMove, ally);
      checkFaint(enemy, ally, 2);
    }
  }

  void enemyFirst() {
    if (firstText) {
      enemy.useAttack(randomEnemyMove, ally);
      checkFaint(enemy, ally, 1);
    } else {
      ally.useAttack(chosenMove, enemy);
      checkFaint(ally, enemy, 2);
    }
  }

  void randomFirst() {
    if (rand > 0.5) {
      if (firstText) {
        ally.useAttack(chosenMove, enemy);
        checkFaint(ally, enemy, 1);
      } else {
        enemy.useAttack(randomEnemyMove, ally);
        checkFaint(enemy, ally, 2);
      }
    } else {
      if (firstText) {
        enemy.useAttack(randomEnemyMove, ally);
        checkFaint(enemy, ally, 1);
      } else {
        ally.useAttack(chosenMove, enemy);
        checkFaint(ally, enemy, 2);
      }
    }
  }

  void checkFaint(Pokemon user, Pokemon target, int turn) {
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
