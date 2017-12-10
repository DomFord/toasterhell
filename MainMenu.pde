class MainMenu {
  int avatarFrame, ticksLast, frameDuration, x1, x2, y, indicator, indicatorY, backgroundyPos;
  float xpos, ypos, speed;
  boolean introDone;
  PImage player1sheet, player2sheet, backgroundGrass;
  PImage[] avatars;

  MainMenu() {
    avatarFrame = 0;
    ticksLast = millis();
    frameDuration = 100;
    xpos = width / 2;
    ypos = -200;
    x1 = -100;
    x2 = width + 100;
    y = 200;
    indicator = 1;
    indicatorY = 155;
    backgroundyPos = 0;
    speed = 5;
    introDone = false;
    player1sheet = loadImage("player_avatar_1.png");
    player2sheet = loadImage("player_avatar_2.png");
    avatars = new PImage[2];
      avatars[0] = player1sheet;
      avatars[1] = player2sheet;
    backgroundGrass = loadImage("grass.png");
    backgroundGrass.resize(width,0);
  }

  void introAnimation() {
    PImage f = player1sheet.get((avatarFrame*60),0,60,66);
    imageMode(CENTER);
    image(f, xpos, ypos);
    int delta = millis() - ticksLast;
    if (delta >= frameDuration) {
      avatarFrame++;
      if (avatarFrame >= 3) {
        avatarFrame = 0;
      }
      ticksLast += delta;
    }
    if (ypos < height - 100) {
      ypos += speed;
      if (ypos > height / 2 && speed > 1) {
        speed -= 0.1;
      }
      } else {
        introDone = true;
      }
    }

    void drawBackground() {
      image(backgroundGrass,width/2,backgroundyPos);
      image(backgroundGrass,width/2,(backgroundyPos-backgroundGrass.height));
      backgroundyPos++;
      if (backgroundyPos >= backgroundGrass.height) {
        backgroundyPos = 0;
      }
    }

    void drawAvatar(PImage avatar) {
      imageMode(CENTER);
      PImage f = avatar.get((avatarFrame*60),0,60,66);
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

    void drawMenu() {
        drawBackground();
        if (!introDone) {
          introAnimation();
          } else {
            drawAvatar(avatars[playerManager.playerSelect - 1]);
            menuTextSlide();
          }
      }

      void menuTextSlide() {
        drawBackground();
        drawAvatar(avatars[playerManager.playerSelect - 1]);
        fill(255);
        textAlign(RIGHT);
        textFont(font, 50);
        text("Welcome to", x1, y);
        textAlign(LEFT);
        textFont(font, 75);
        text("TOASTERHELL", x2, y + 100);
        if (x1 < width / 2 && x2 > width / 5) {
          x1 += 5;
          x2 -= 10;
        }
        textFont(font, 40);
        textAlign(CENTER, CENTER);
        if (millis() / 1000 % 2 == 0)
        text("Press SPACE", width / 2, height - 200);
      }

      void menuSelect() {
        drawBackground();
        drawAvatar(avatars[playerManager.playerSelect - 1]);
        fill(255);
        textAlign(LEFT, CENTER);
        textFont(font, 50);
        text("CAMPAIGN", 100, 150);
        text("ENDLESS", 100, 250);
        text("HISCORES", 100, 350);
        text("ENDLESS HISCORES", 100, 450);
        text("EXIT", 100, 550);
        textAlign(RIGHT, CENTER);
        textFont(font, 32);
        if (millis() / 100 % 20 != 0) {
          text("press ENTER or SPACE to select\n arrow keys to change avatar", width - 50, 50);
        }
        rectMode(CENTER);
        if (millis() / 100 % 5 == 0) {
          if (indicator < 5) {
            indicatorY = 55 + (indicator * 100);
          } else {
            indicatorY = 555;
          }
          rect(75, indicatorY, 10, 40);
        }
      }
    }
