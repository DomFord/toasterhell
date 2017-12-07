class BasicEnemy {
  int timeStamp, shootRateModifier;
  float xpos, ypos, speed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  //ArrayList<Enemy> bullets;

  BasicEnemy() {
    timeStamp = 0;
    shootRateModifier = 0;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed = 5;
    size = 50;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    speedModifier = 0.2;
    brakeModifier = 0.5;
    alive = true;
    shooting = false;
    //bullets = new ArrayList<EnemyBullet>;
  }

  void drawEnemy() {
    if (alive) {
      noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);
      move();
      bulletCollision();
      } else {
        //death();
      }
    }

    void move() {
      ypos += speed;
    }

    void bulletCollision() {
        for (int i = playerManager.bullets.size() - 1; i >= 0; i--) {
          if (playerManager.bullets.get(i).xpos - playerManager.bullets.get(i).size / 2 > xpos - size / 2
              && playerManager.bullets.get(i).xpos + playerManager.bullets.get(i).size / 2 < xpos + size / 2
              && playerManager.bullets.get(i).ypos - playerManager.bullets.get(i).size / 2 > ypos - size / 2
              && playerManager.bullets.get(i).ypos + playerManager.bullets.get(i).size / 2 < ypos + size / 2) {
                println("Enemy hit!");
                alive = false;
              }
        }
    }
}
