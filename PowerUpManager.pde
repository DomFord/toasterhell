class PowerUpManager {
  ArrayList<PowerUp> powerUps;
  int timeStamp;

  PowerUpManager() {
    powerUps = new ArrayList<PowerUp>();
    timeStamp = 0;
  }

  void powerUpSpawner() { //spawns powerups at regular intervals
    if (ticksElapsed > timeStamp + 400) {
      powerUps.add(new PowerUp());
      timeStamp = ticksElapsed;
    }

    for (int i = powerUps.size() - 1; i >= 0; i--) {
      powerUps.get(i).drawPowerUp();
    }
  }
}
