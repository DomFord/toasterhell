class EnemyManager {
  ArrayList<BasicEnemy> basicEnemies;
  ArrayList<EnemyBullet> bullets;
  int timeStamp, enemyCounter, maxEnemies;

  EnemyManager() {
    enemyCounter = 0;
    basicEnemies = new ArrayList<BasicEnemy>();
    bullets = new ArrayList<EnemyBullet>();
    timeStamp = 0;
  }

  void enemySpawner() { //handles spawning of enemies at regular intervals depending on game mode selected and removes them when they get out of screen bounds
    enemyKiller();
    if (gamestate < 6) {
      if (enemyCounter >= 20) {
        for (int i = basicEnemies.size() - 1; i >= 0; i--) {
          basicEnemies.remove(i);
        }
        for (int i = bullets.size() - 1; i >= 0; i--) {
          bullets.remove(i);
        }
        for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
          powerUpManager.powerUps.remove(i);
        }
        menuIndex++;
        enemyCounter = 0;
        maxEnemies = 0;
      } else {
        if (ticksElapsed > timeStamp + 100 && maxEnemies < 20) {
          basicEnemies.add(new BasicEnemy(gamestate));
          timeStamp = ticksElapsed;
          maxEnemies ++;
        }
      }
  } else {
    if (ticksElapsed > timeStamp + 100) {
      basicEnemies.add(new BasicEnemy((int)random(1, 5)));
      timeStamp = ticksElapsed;
    }
  }

    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      basicEnemies.get(i).drawEnemy();
    }

    for (int i = bullets.size() - 1; i >= 0; i--) {
      bullets.get(i).drawBullet();
      if (bullets.get(i).ypos > height) {
        bullets.remove(i);
      }
      else if (bullets.get(i).ypos < 0) {
        bullets.remove(i);
      }
      else if (bullets.get(i).xpos < 0) {
        bullets.remove(i);
      }
      else if (bullets.get(i).xpos > width) {
        bullets.remove(i);
      }
    }
  }

  void enemyKiller() { //removes the enemy when it gets shot and creates a deathblossom of bullets
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (!basicEnemies.get(i).alive) {
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, 150));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, -150));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 150, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -150, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -100, 100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -100, -100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 100, -100));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 100, 100));
        basicEnemies.remove(i);
        enemyCounter++;
      }
    }
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (basicEnemies.get(i).ypos > height + 100) {
        basicEnemies.remove(i);
        enemyCounter++;
      }
    }
  }
}
