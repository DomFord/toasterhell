class EnemyBullet {
  float xpos, ypos, ySpeed, xSpeed, size;
  boolean collided;

  EnemyBullet(float x, float y, float xs, float ys) {
    xpos = x;
    ypos = y;
    ySpeed = ys;
    xSpeed = xs;
    size = 10;
  }

  void drawBullet() {
    rectMode(CENTER);
    fill(218, 44, 56);
    stroke(255, 255, 56);
    rect(xpos, ypos, size, size);
    ypos += ySpeed * float(millis() - ticksLastUpdate)*0.001;
    xpos += xSpeed * float(millis() - ticksLastUpdate)*0.001;
  }
}
