class Highscores {
  int xpos, ypos, j;
  boolean printed;

  Highscores() {
    xpos = width / 2;
    ypos = 100;
    printed = false;
    j = 1;
  }

  void displayHighscores() {
    //fill(scoreboard.scoreBoardBGCol);
    background(255);
    textAlign(CENTER);
    text("HIGHSCORES", xpos, 50);

    FileManager.saveScore("memes.dat", scores);
    scores = FileManager.loadScore("memes.dat");
    Collections.sort(scores);
    //Collections.reverse(scores);

    for (int i = scores.size() - 1; i >= scores.size() - 11; i--) {
      textAlign(LEFT);
      text(scores.get(i).playerName(), 100, height + 100 - (i * 30));
      textAlign(RIGHT);
      text(scores.get(i).playerScore(), width - 100, height + 100 - (i * 30));
    }
    if (!printed) {
      println("HIGHSCORES: ");
      for (int i = 0; i < scores.size(); i++) {
        println("Score " + i + ": " + scores.get(i).playerName() + " " + scores.get(i).playerScore() + ".");
      }
      printed = true;
  }
}
}
