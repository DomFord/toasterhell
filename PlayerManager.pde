/*
This script handles the player, both what player is selected, player life, weapon, controls etc.
*/
class PlayerManager{
  int timeStamp, shootRateModifier, playerSelect, avatarFrame, ticksLast, frameDuration, score, health;
  float xpos, ypos, maxSpeed, size, leftSpeed, rightSpeed, upSpeed, downSpeed, speedModifier, brakeModifier, hitBlinkOpacity;
  boolean alive, left, right, up, down, shooting;
  ArrayList<PlayerBullet> bullets;
  PImage player1sheet, player2sheet, heart;

  PlayerManager() {
    timeStamp = 0;
    alive = true;
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

  void avatarStatSetter() {
    if (playerSelect == 1) {
      health = 3;
      shootRateModifier = 10;
    } else {
      health = 5;
      shootRateModifier = 25;
    }
  }

  void drawPlayer() {
    if (alive) {
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
    }

  void movePlayer() {
    speedHandler();
    shootHandler();
    bulletCollision();
    powerUpCollision();
    hitBlinker();
    displayLife();
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

  void speedHandler() {
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

  void speedDebug() {
    if (millis() / 1000 % 2 == 0) {
      println("Left: " + leftSpeed);
      println("Right: " + rightSpeed);
      println("Up: " + upSpeed);
      println("Down: " + downSpeed);
    }
  }

  void shootHandler() {
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

  void bulletCollision() {
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

  void powerUpCollision() {
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

  void hitBlinker() {
    fill(218, 44, 56, hitBlinkOpacity);
    rectMode(CENTER);
    rect(width / 2, height / 2, width, height);
    if (hitBlinkOpacity > 0) {
      hitBlinkOpacity -= 5;
    }
  }

  void displayLife() {
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

  void displayScore() {
    fill(255);
    textSize(32);
    text(score, 80, height - 80);
  }

  void displayCurrentLevel() {
    fill(255);
    textSize(24);
    if (gamestate < 6) {
      text("LEVEL " + gamestate, 150, 40);
    } else {
      text("ENDLESS LEVEL", 150, 40);
    }
  }

    void death() {
      if(playerManager.score > highScoreList.get(9).points){  //checks if the player has set a new highscore better than the lowest one currently on the list
        menuIndex = 5;
      }
      else{
        menuIndex = 6;
      }
    }
  }
