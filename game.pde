// 主遊戲類
class Game {
  StartScreen startScreen;
  Level level;
  PauseScreen pauseScreen;
  EndScreen endScreen;
  HelpScreen helpScreen;
  NavigationBar navBar;
  ToolBar toolBar;

  boolean gameStarted;
  boolean gameOver;

  Game() {
    startScreen = new StartScreen();
    pauseScreen = new PauseScreen();
    endScreen = new EndScreen();
    helpScreen= new HelpScreen();
    navBar = new NavigationBar();
    level = new Level();
    level.generateLevel();
    toolBar=new ToolBar();

    gameStarted = false;
    gameOver = false;
  }

  void draw() {
    if (!gameStarted) {
      startScreen.display();
    } else if (!gameOver) {
      level.update();
      if (currentPlace!="veg game"&&currentPlace!="veg instruction"&&currentPlace!="meat game"&&currentPlace!="meat instruction"&&
        currentPlace!="shelf game"&&currentPlace!="shelf instruction"&&currentPlace!="intro"&&currentPlace!="scenery") {
        toolBar.display();
      }
      if (currentPlace!="veg game"||currentPlace!="meat game"||currentPlace!="shelf game") {
        navBar.display();
      }
      helpScreen.display();
      pauseScreen.display();
    } else if (gameOver) {
      endScreen.display();
    }
  }
  void keyPressed() {
    if (!gameStarted) {
      startScreen.handleKeyPress();
    } else if (!gameOver) {
      level.handleKeyPress();
    } else if (gameOver) {
      endScreen.handleKeyPress();
    }
  }
}
