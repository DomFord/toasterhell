class BasicEnemy {
  int timeStamp, shootRateModifier, shootCounter, ticksLast, cycleCount,xMove, yMove, enemyState;
  float xpos, ypos, speed1, speed2, speed3, speed4, speed5, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier;
  boolean alive, shooting;
  ArrayList<EnemyBullet> bullets;
  PImage enemyImage1, enemyImage2, enemyImage3, enemyImage4, enemyImage5;
  PImage[] enemyImages;

  BasicEnemy(int level) {
    xMove = 0;
    yMove = 0;
    enemyState = level;
    cycleCount = 0;
    ticksLast = millis();
    shootCounter = 0;
    timeStamp = 0;
    shootRateModifier = 60;
    xpos = random(0 + size, width - size);
    ypos = -100;
    speed1 = 50;
    speed2 = 70;
    speed3 = 90;
    speed4 = 110;
    speed5 = 130;
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
    enemyImages = new PImage[5];
      enemyImages[0] = enemyImage1;
      enemyImages[1] = enemyImage2;
      enemyImages[2] = enemyImage3;
      enemyImages[3] = enemyImage4;
      enemyImages[4] = enemyImage5;
  }

  void drawEnemy() { //draws the enemy depending on level selected shows different images
    if (alive) {
      move();
      bulletCollision();
      shootHandler();
      imageMode(CENTER);
      image(enemyImages[enemyState - 1], xpos, ypos);
      } else {
        //death();
      }
    }

    void move() { //handles the different movement patterns for the various enemies
      switch (enemyState){
        case 1:
          ypos += speed1 * float(millis() - ticksLastUpdate)*0.001;
        break;
        case 2:
          if (xMove < 250){
            xpos += speed1 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else if (xMove < 500){
            xpos -= speed2 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 250){
            ypos += speed3 * float(millis() - ticksLastUpdate)*0.001;
            yMove ++;
          }
          else if (yMove < 500){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 3:
          if (xMove < 50){
            xpos += speed2 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else if (xMove < 100){
            xpos -= speed2 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 100){
            ypos += speed4 * float(millis() - ticksLastUpdate)*0.001;
            yMove ++;
          }
          else if (yMove < 150){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 4:
          if (xMove < 50){
            xpos += speed5 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else if (xMove < 100){
            xpos -= speed5 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 100){
            ypos += speed4 * float(millis() - ticksLastUpdate)*0.001;
            yMove ++;
          }
          else if (yMove < 150){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
        case 5:
          if (xMove < 50){
            xpos += speed1 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else if (xMove < 250){
            xMove ++;
          }
          else if (xMove < 300){
            xpos -= speed1 * float(millis() - ticksLastUpdate)*0.001;
            xMove ++;
          }
          else if (xMove < 500){
            xMove ++;
          }
          else{
            xMove = 0;
          }
          if (yMove < 50){
            yMove ++;
          }
          else if (yMove < 100){
            ypos += speed3 * float(millis() - ticksLastUpdate)*0.001;
            yMove ++;
          }
          else if (yMove < 250){
            yMove ++;
          }
          else{
            yMove = 0;
          }
        break;
      }
    }

    void bulletCollision() { //checks collision with player bullets and calls to kill the enemy and remove the player bullet
        for (int i = playerManager.bullets.size() - 1; i >= 0; i--) {
          if (playerManager.bullets.get(i).xpos - playerManager.bullets.get(i).size / 2 > xpos - size / 2
              && playerManager.bullets.get(i).xpos + playerManager.bullets.get(i).size / 2 < xpos + size / 2
              && playerManager.bullets.get(i).ypos - playerManager.bullets.get(i).size / 2 > ypos - size / 2
              && playerManager.bullets.get(i).ypos + playerManager.bullets.get(i).size / 2 < ypos + size / 2) {
                println("Enemy hit!");
                alive = false;
                playerManager.bullets.remove(i);
                playerManager.score += enemyState * 10;
                println(playerManager.score);
              }
        }
    }

    void shootHandler() { //controls the various shooting patterns for the different enemy types
      if (shooting) {
        int delta = millis() - ticksLast;
        switch (enemyState){
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
