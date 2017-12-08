class BasicEnemy {
  int timeStamp, shootRateModifier, shootCounter;
  float xpos, ypos, speed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  ArrayList<EnemyBullet> bullets;
  PImage enemyImage1;
  PImage enemyImage2;
  PImage enemyImage3;
  PImage enemyImage4;
  PImage enemyImage5;

  BasicEnemy() {
    shootCounter = 0;
    timeStamp = 0;
    shootRateModifier = 60;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed = 50;
    size = 50;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    speedModifier = 0.2;
    brakeModifier = 0.5;
    alive = true;
    shooting = true;
    bullets = new ArrayList<EnemyBullet>();
    enemyImage1 = loadImage("enemy_grass.png");
    enemyImage2 = loadImage("enemy_water.png");
    enemyImage3 = loadImage("enemy_rock.png");
    enemyImage4 = loadImage("enemy_ice.png");
    enemyImage5 = loadImage("enemy_lava.png");
  }

  void drawEnemy() {
    if (alive) {
      move();
      bulletCollision();
      shootHandler();
      imageMode(CENTER);
      switch (gamestate){
        case 1:
        image(enemyImage1,xpos,ypos);
        break;
        case 2:
        image(enemyImage2,xpos,ypos);
        break;
        case 3:
        image(enemyImage3,xpos,ypos);
        break;
        case 4:
        image(enemyImage4,xpos,ypos);
        break;
        case 5:
        image(enemyImage5,xpos,ypos);
        break;
      }
      /*noFill();
      rectMode(CENTER);
      rect(xpos, ypos, size, size);*/

      } else {
        //death();
      }
    }

    void move() {
      ypos += speed * float(millis() - ticksLastUpdate)*0.001;
    }

    void bulletCollision() {
        for (int i = playerManager.bullets.size() - 1; i >= 0; i--) {
          if (playerManager.bullets.get(i).xpos - playerManager.bullets.get(i).size / 2 > xpos - size / 2
              && playerManager.bullets.get(i).xpos + playerManager.bullets.get(i).size / 2 < xpos + size / 2
              && playerManager.bullets.get(i).ypos - playerManager.bullets.get(i).size / 2 > ypos - size / 2
              && playerManager.bullets.get(i).ypos + playerManager.bullets.get(i).size / 2 < ypos + size / 2) {
                println("Enemy hit!");
                alive = false;
                playerManager.bullets.remove(i);
                playerManager.score += 10;
                println(playerManager.score);
              }
        }
    }

    void shootHandler() {
      if (shooting) {
        switch (gamestate){
          case 1:
          shootRateModifier = 120;
          if (ticksElapsed > timeStamp + shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            timeStamp = ticksElapsed;
          }
          break;
          case 2:
          shootRateModifier = 200;
          if (ticksElapsed > timeStamp + shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            timeStamp = ticksElapsed;
          }
          break;
          case 3:
          if (shootCounter == 10){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 30){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 50){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 300){
            shootCounter = 0;
          }
          shootCounter ++;
          break;
          case 4:
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 60){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 80){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 100){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
          }
          if (shootCounter == 400){
            shootCounter = 0;
          }
          shootCounter ++;
          break;
          case 5:
          if (shootCounter == 10){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 20){
            bullets.add(new EnemyBullet(xpos, ypos, -100, 100));
          }
          if (shootCounter == 30){
            bullets.add(new EnemyBullet(xpos, ypos, -150, 00));
          }
          if (shootCounter == 40){
            bullets.add(new EnemyBullet(xpos, ypos, -100, -100));
          }
          if (shootCounter == 50){
            bullets.add(new EnemyBullet(xpos, ypos, 0, -150));
          }
          if (shootCounter == 60){
            bullets.add(new EnemyBullet(xpos, ypos, 100, -100));
          }
          if (shootCounter == 70){
            bullets.add(new EnemyBullet(xpos, ypos, 150, 0));
          }
          if (shootCounter == 80){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 100));
          }
          if (shootCounter == 90){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
          }
          if (shootCounter == 300){
            shootCounter = 0;
          }
          shootCounter ++;
          break;
        }
      }
      for (int i = bullets.size() - 1; i >= 0; i--) {
        bullets.get(i).drawBullet();
        if (bullets.get(i).ypos > height) {
          bullets.remove(i);
        }
      }
    }
}
