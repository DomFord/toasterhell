class BasicEnemy {
  int timeStamp, shootRateModifier, shootCounter, ticksLast, cycleCount;
  float xpos, ypos, speed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  ArrayList<EnemyBullet> bullets;
  PImage enemyImage1;
  PImage enemyImage2;
  PImage enemyImage3;
  PImage enemyImage4;
  PImage enemyImage5;

  BasicEnemy() {
    cycleCount = 0;
    ticksLast = millis();
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
        int delta = millis() - ticksLast;
        println(cycleCount);
        switch (gamestate){
          case 1:
          shootRateModifier = 2000;
          if (delta > shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
          }
          break;
          case 2:
          shootRateModifier = 2500;
          if (delta > shootRateModifier) {
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            ticksLast += delta;
          }
          break;
          case 3:
            shootCounter = 500;
            if (delta > shootCounter && cycleCount < 3){
              bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
              ticksLast += delta;
              cycleCount++;
            }
            else if (delta > shootCounter && cycleCount > 2){
              ticksLast += delta;
              cycleCount++;
            }
            else if (cycleCount >= 10){
              ticksLast += delta;
              cycleCount = 0;
            }
          break;
          case 4:
          shootCounter = 400;
          if (delta > shootCounter && cycleCount < 3){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 150));
            bullets.add(new EnemyBullet(xpos, ypos, -100, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount > 2){
            ticksLast += delta;
            cycleCount++;
          }
          else if (cycleCount >= 8){
            ticksLast += delta;
            cycleCount = 0;
          }
          break;
          case 5:
          shootCounter = 300;
          if (delta > shootCounter && cycleCount == 0){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 1){
            bullets.add(new EnemyBullet(xpos, ypos, -100, 100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 2){
            bullets.add(new EnemyBullet(xpos, ypos, -150, 00));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 3){
            bullets.add(new EnemyBullet(xpos, ypos, -100, -100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 4){
            bullets.add(new EnemyBullet(xpos, ypos, 0, -150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 5){
            bullets.add(new EnemyBullet(xpos, ypos, 100, -100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 6){
            bullets.add(new EnemyBullet(xpos, ypos, 150, 0));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 7){
            bullets.add(new EnemyBullet(xpos, ypos, 100, 100));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount == 8){
            bullets.add(new EnemyBullet(xpos, ypos, 0, 150));
            ticksLast += delta;
            cycleCount++;
          }
          else if (delta > shootCounter && cycleCount > 8){
            ticksLast += delta;
            cycleCount++;
          }
          else if (cycleCount >= 20){
            ticksLast += delta;
            cycleCount = 0;
          }
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
