class PlayerBullet {
  float xpos, ypos, speed, size;
  boolean collided;

  PlayerBullet(float x, float y) {
    xpos = x;
    ypos = y;
    speed = 200;
    size = 3;
  }

  void drawBullet() { //draws a simple player bullet
    rectMode(CENTER);
    fill(255);
    stroke(0,120,255);
    rect(xpos, ypos, size, size * 5);

    if (!collided) {
      ypos -= speed * float(millis() - ticksLastUpdate)*0.001;
    }
  }
}
