class HighscoreEntry {
  int letterSelect, letterRoll, lettersLocked, xpos, ypos;
  String a, blank, savedName;
  char[] alphabet, tag;

  HighscoreEntry() {
    a = "ABCDEFGHIJKLMNOPQRSTUVWXYXÆØÅ1234567890";
    blank = "   ";
    alphabet = a.toCharArray();
    tag = blank.toCharArray();
    letterSelect = 0;
    letterRoll = 0;
    lettersLocked = 0;
    xpos = width / 2;
    ypos = 400;
  }

  void displayNameSelect() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);

    if (letterSelect <= 2) {
      text("ENTER YOUR NAME", width / 2, 200);
      } else {
        text("PRESS ENTER\n TO CONFIRM", width / 2, 200);
      }

      //letterSelectIndicator();

      letterSelect();

      String name = new String(tag);
      displayLockedLetters();
    }

    void letterSelect() {
      switch (letterSelect) {
        case 0:
        text(alphabet[letterRoll], xpos - 50, ypos);
        break;
        case 1:
        text(alphabet[letterRoll], xpos, ypos);
        break;
        case 2:
        text(alphabet[letterRoll], xpos + 50, ypos);
        break;
      }
    }

    void displayLockedLetters() {
      if (lettersLocked > 0) {              // If the number of letters locked is above 0, then the first locked character is displayed along with the rectangle indicator.
        text(tag[0], xpos - 50, ypos);
        rect(xpos - 53, ypos + 25, 50, 10);
      }

      if (lettersLocked > 1) {              // If it's above 1, then also show the second letter.
      text(tag[1], xpos, ypos);
      rect(xpos - 3, ypos + 25, 50, 10);
    }

    if (lettersLocked > 2) {             // And if it's above 2, display the final letter as well.
    text(tag[2], xpos + 50, ypos);
    rect(xpos + 47, ypos + 25, 50, 10);
  }
}

void lockLetter(int letter) {
  tag[letterSelect] = alphabet[letter];
  lettersLocked++;
  letterSelect++;
  letterRoll = 0;
}

void deleteLetter() {
  tag[letterSelect] = 32;
  lettersLocked--;
  letterSelect--;
}
/*
void letterSelectIndicator() {           // This function simply displays a flashing box to help indicate to the player which letter they're currently choosing.
rectMode(CENTER);                      // Draw these rectangles from the centre rather than top left.

if ( (millis() / 1000) % 2 == 0 ) {    // Using the same method of flashing as earlier to make the indicator blink.
stroke(scoreBoardCol);
fill(scoreBoardCol);
} else {
stroke(scoreBoardBGCol);
fill(scoreBoardBGCol);
}

switch (letterSelect) {               // Depending on which letter the player is selecting, the box will appear underneath it.
case 0:
rect(xpos - 53, ypos + 25, 50, 10);
break;
case 1:
rect(xpos - 3, ypos + 25, 50, 10);
break;
case 2:
rect(xpos + 47, ypos + 25, 50, 10);
break;
}
} */

void setName() {                                // And finally we need to save the player's chosen name.
savedName = new String(tag);                  // Creates a new string from the tag character array.
scores.add(new Score(savedName, playerManager.score)); // Creates a new Score object to the scores ArrayList with the player's name and score.
FileManager.saveScore("memes.dat", scores);
scores = FileManager.loadScore("memes.dat");
Collections.sort(scores);
Collections.reverse(scores);
}
  }
