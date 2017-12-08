class EnemyManager {
  ArrayList<BasicEnemy> basicEnemies;
  ArrayList<EnemyBullet> bullets;
  int timeStamp;

  EnemyManager() {
    basicEnemies = new ArrayList<BasicEnemy>();
    bullets = new ArrayList<EnemyBullet>();
    timeStamp = 0;
  }

  void enemySpawner() {
    //switch case here to spawn the correct numbers and types of enemies per level
    enemyKiller();
    if (ticksElapsed > timeStamp + 100) {
      basicEnemies.add(new BasicEnemy());
      timeStamp = ticksElapsed;
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

  void enemyKiller() {
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (!basicEnemies.get(i).alive) {
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, 4));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 0, -4));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 4, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -4, 0));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -3, 3));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, -3, -3));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 3, -3));
        bullets.add(new EnemyBullet(basicEnemies.get(i).xpos, basicEnemies.get(i).ypos, 3, 3));
        basicEnemies.remove(i);
      }
    }
  }
}
