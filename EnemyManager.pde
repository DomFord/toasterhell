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
    switch (gamestate) {
      case 1:
        if (ticksElapsed > timeStamp + 100) {
          basicEnemies.add(new BasicEnemy());
          timeStamp = ticksElapsed;
      }
        for (int i = basicEnemies.size() - 1; i >= 0; i--) {
          basicEnemies.get(i).drawEnemy();
          }
        break;
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
