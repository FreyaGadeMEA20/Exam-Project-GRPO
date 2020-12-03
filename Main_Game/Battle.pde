class Battle {

  int allySpeed;
  int enemySpeed;

  int speedOrder;
  float rand;
  String[] text;

  int counter;
  boolean firstText = true;
  int textNumber = 0;
  int textOffset = 20;

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
    println(allySpeed + " vs " + enemySpeed);

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
    
    if (speedOrder == 1) {
      text = new String[]{allyAttack, enemyAttack};
    } else if (speedOrder == 2) {
      text = new String[]{enemyAttack, allyAttack};

      // In the off chance that both pokemon are tied in speed, i simulate a coinflip with random to just randomly choose which one goes first.
    } else if (speedOrder == 3) {
      rand = random(1);
      if (rand > 0.5) {
        text = new String[]{allyAttack, enemyAttack};
      } else {
        text = new String[]{enemyAttack, allyAttack};
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
        firstText = false;
      }
    } else {
      if (counter < text[textNumber].length()) {
        counter++;
      } else if (counter >= text[textNumber].length()) {
        useAttack();
        delay(3000);
        battlefield.chooseMove = true;
      }
    }

    text(text[textNumber].substring(0, counter), textOffset, battlefield.dialogueBox[1]-textOffset);
  }

  void useAttack() {
    if (speedOrder == 1) {
      if (firstText) {
        ally.useAttack(chosenMove, enemy);
      } else {
        enemy.useAttack(randomEnemyMove, ally);
      }
    } else if (speedOrder == 2) {
      if (firstText) {
        enemy.useAttack(randomEnemyMove, ally);
      } else {
        ally.useAttack(chosenMove, enemy);
      }
    } else if (speedOrder == 3) {

      if (rand > 0.5) {
        if (firstText) {
          ally.useAttack(chosenMove, enemy);
        } else {
          enemy.useAttack(randomEnemyMove, ally);
        }
      } else {
        if (firstText) {
          enemy.useAttack(randomEnemyMove, ally);
        } else {
          ally.useAttack(chosenMove, enemy);
        }
      }
    }
  }
}
