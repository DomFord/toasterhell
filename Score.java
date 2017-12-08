import java.io.Serializable; // This is where things got more confusing (for me at least)!
import java.util.Comparator; // We need to import two Java libraries used to serialize and then sort the ArrayList of scores.

public class Score implements Serializable, Comparable {  // Create the class Score and make sure it's implementing Serializable and Comparable.
  String name;  // For the highscores, we only need to save the player's name,
  int score;    // and score.

  Score(String tag, int points) { // The constructor takes two arguments, for the player's name and score.
    name = tag;
    score = points;
  }

  String playerName() { // A function that simply returns the player's name.
    return name;
  }

  public int playerScore() {  // A function that simply returns the player's score.
    return score;
  }

  public int compareTo(Object other) {              // This function is used by the comparator to compare two scores to see which is higher.
    int otherScore = ((Score) other).playerScore();
    return this.score - otherScore;                 // The answer is returned as a value that will either be positive or negative.
  }

  public static Comparator<Score> sortHighscores = new Comparator<Score>() {  // This is the comparator which will sort the highscores into score order.
    public int compare(Score s1, Score s2) {                                  // It contains a function that compares two Score objects and returns an integer.
      int score1 = s1.playerScore();                                          // Specifies for both objects that we're interested in the score variable, given by the playerScore() function.
      int score2 = s2.playerScore();
      return score1 - score2;                                                 // Returns either a positive or negative integer, which tells the sorting function which should be higher.
    }
  };
}
