/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  int timeStamp, shootRateModifier, playerSelect, avatarFrame, ticksLast, frameDuration, score, health;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier, hitBlinkOpacity;
  boolean left, right, up, down, shooting;
  ArrayList<PlayerBullet> bullets;
  PImage player1sheet, player2sheet, heart;

  PlayerManager() {
    timeStamp = 0;
    xpos = width / 2;
    ypos = height - 75;
    maxSpeed = 400;
    size = 30;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    hitBlinkOpacity = 0;
    speedModifier = 20;
    brakeModifier = 30;
    bullets = new ArrayList<PlayerBullet>();
    player1sheet = loadImage("player_avatar_1.png");
    player2sheet = loadImage("player_avatar_2.png");
    heart = loadImage("heart.png");
    playerSelect = 1;
    avatarFrame = 0;
    ticksLast = millis();
    frameDuration = 100;
    score = 0;
    health = 3;
    shootRateModifier = 10;
  }

  void avatarStatSetter() { //this deals with the stats of the two different player avatars - health, speed and shoot rate.
    leftSpeed = 0;
    rightSpeed = 0;
    upSpeed = 0;
    downSpeed = 0;
    xpos = width / 2;
    ypos = height - 75;
    left = false;
    right = false;
    up = false;
    down = false;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    score = 0;
    if (playerSelect == 1) {
      health = 3;
      shootRateModifier = 10;
      speedModifier = 20;
    } else {
      health = 5;
      shootRateModifier = 25;
      speedModifier = 10;
    }
  }

  void drawPlayer() { //this draws the player at the location defined by the movePlayer function, shows a different picture for the two avatars.
    speedHandler();
    movePlayer();
    shootHandler();
    displayScore();
    displayCurrentLevel();

    if(health == 0){
      death();
    }
    imageMode(CENTER);
    if(playerSelect == 1){
      PImage f = player1sheet.get((avatarFrame*60),0,60,66);
      image(f,xpos,ypos);
      int delta = millis() - ticksLast;
      if (delta >= frameDuration){
        avatarFrame++;
        if(avatarFrame >= 3){
          avatarFrame = 0;
        }
        ticksLast += delta;
      }
    }
    else if (playerSelect == 2) {
      PImage f = player2sheet.get((avatarFrame*60),0,60,66);
      image(f,xpos,ypos);
      int delta = millis() - ticksLast;
      if (delta >= frameDuration) {
        avatarFrame++;
        if(avatarFrame >= 3) {
          avatarFrame = 0;
        }
        ticksLast += delta;
        }
      }
    }

  void movePlayer() { //here, movement is controlled and some movement related functions are called.
    speedHandler();
    shootHandler();
    bulletCollision();
    powerUpCollision();
    hitBlinker();
    displayLife();
    println(xpos);
    println(ypos);
    if (xpos - size < 0) {
      leftSpeed = 0;
    }
    else {
      xpos -= leftSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (xpos + size > width) {
      rightSpeed = 0;
    }
    else {
      xpos += rightSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (ypos - size < 0) {
      upSpeed = 0;
    }
    else {
      ypos -= upSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
    if (ypos + size > height) {
      downSpeed = 0;
    }
    else {
      ypos += downSpeed * float(millis() - ticksLastUpdate) * 0.001;
    }
  }

  void speedHandler() { //this handles acceleration and braking of speed for the movePlayer function
    if (left) {
      leftSpeed = constrain(leftSpeed, 0, maxSpeed) + speedModifier;
    } else if (!left) {
      leftSpeed = constrain(leftSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (right) {
      rightSpeed = constrain(rightSpeed, 0, maxSpeed) + speedModifier;
    } else if (!right) {
      rightSpeed = constrain(rightSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (up) {
      upSpeed = constrain(upSpeed, 0, maxSpeed) + speedModifier;
    } else if (!up) {
      upSpeed = constrain(upSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
    if (down) {
      downSpeed = constrain(downSpeed, 0, maxSpeed) + speedModifier;
    } else if (!down) {
      downSpeed = constrain(downSpeed, brakeModifier, maxSpeed) - brakeModifier;
    }
  }

  void shootHandler() { //here, the shooting happens!
    if (shooting) {
      if (ticksElapsed > timeStamp + shootRateModifier) {
        bullets.add(new PlayerBullet(xpos, ypos));
        score--;
        timeStamp = ticksElapsed;
      }
    }
    for (int i = bullets.size() - 1; i >= 0; i--) {
      bullets.get(i).drawBullet();
      if (bullets.get(i).ypos < 0) {
        bullets.remove(i);
      }
    }
  }

  void bulletCollision() { //collision is checked with each bullet from each enemy
    for (int k = enemyManager.bullets.size() - 1; k >= 0; k--) {
      if (enemyManager.bullets.get(k).xpos - enemyManager.bullets.get(k).size / 2 > xpos - size
          && enemyManager.bullets.get(k).xpos + enemyManager.bullets.get(k).size / 2 < xpos + size
          && enemyManager.bullets.get(k).ypos - enemyManager.bullets.get(k).size / 2 > ypos - size
          && enemyManager.bullets.get(k).ypos + enemyManager.bullets.get(k).size / 2 < ypos + size) {
            println("Player hit!");
            enemyManager.bullets.remove(k);
            hitBlinkOpacity = 255 / 2;
            health--;
            println(health);
      }
    }
    for (int i = enemyManager.basicEnemies.size() - 1; i >= 0; i--) {
      for (int j = enemyManager.basicEnemies.get(i).bullets.size() - 1; j >= 0; j--) {
        if (enemyManager.basicEnemies.get(i).bullets.get(j).xpos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > xpos - size
            && enemyManager.basicEnemies.get(i).bullets.get(j).xpos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < xpos + size
            && enemyManager.basicEnemies.get(i).bullets.get(j).ypos - enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 > ypos - size
            && enemyManager.basicEnemies.get(i).bullets.get(j).ypos + enemyManager.basicEnemies.get(i).bullets.get(j).size / 2 < ypos + size) {
              println("Player hit!");
              enemyManager.basicEnemies.get(i).bullets.remove(j);
              hitBlinkOpacity = 255 / 2;
              health--;
        }
      }
    }
  }

  void powerUpCollision() { //and here we check if the player has picked up some health
    for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
      if (powerUpManager.powerUps.get(i).ypos > ypos - size) {
        if (powerUpManager.powerUps.get(i).xpos > xpos - size
            && powerUpManager.powerUps.get(i).xpos < xpos + size) {
            health++;
            powerUpManager.powerUps.remove(i);
    }
  }
}
}

  void hitBlinker() { //this flashes the screen when the player gets hit
    fill(218, 44, 56, hitBlinkOpacity);
    rectMode(CENTER);
    rect(width / 2, height / 2, width, height);
    if (hitBlinkOpacity > 0) {
      hitBlinkOpacity -= 5;
    }
  }

  void displayLife() { //displays hearts in the lower right corner to show health left
    for (int i = 0; i <= health - 1; i++) {
      if (health >= 3) {
        if (millis() / 100 % 10 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      } else if (health == 2) {
        if (millis() / 100 % 5 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      } else {
        if (millis() / 100 % 2 != 0) {
          image(heart, width - 40 - (i * 35), height - 40);
        }
      }
    }
  }

  void displayScore() { //displays score in bottom left corner
    fill(255);
    textSize(32);
    text(score, 80, height - 80);
  }

  void displayCurrentLevel() { //displays current level in top left corner
    fill(255);
    textSize(24);
    textAlign(LEFT, CENTER);
    if (gamestate < 6) {
      text("LEVEL " + gamestate, 30, 40);
    } else {
      text("ENDLESS LEVEL", 200, 40);
    }
  }

    void death() { //decides what happens when the player dies; depending on game mode (campaign or endless), it checks if the score is higher than the last entry on the list and sends you to either tag input or highscore screen
      switch (gamestate){
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          if(playerManager.score > highScoreList.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
            menuIndex = 5;
          }
          else{
            menuIndex = 6;
          }
        break;
        case 6:
          if(playerManager.score > highScoreListEndless.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
            menuIndex = 7;
          }
          else{
            menuIndex = 8;
          }
        break;
      }
      for (int i = enemyManager.basicEnemies.size() - 1; i >= 0; i--) {
        enemyManager.basicEnemies.remove(i);
      }
      for (int i = powerUpManager.powerUps.size() - 1; i >= 0; i--) {
        powerUpManager.powerUps.remove(i);
      }
    }
  }
