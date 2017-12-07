class EnemyManager {
  ArrayList<BasicEnemy> basicEnemies;
  int timeStamp;

  EnemyManager() {
    basicEnemies = new ArrayList<BasicEnemy>();
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
  }

  void enemyKiller() {
    for (int i = basicEnemies.size() - 1; i >= 0; i--) {
      if (!basicEnemies.get(i).alive) {
        basicEnemies.remove(i);
      }
    }
  }
}
