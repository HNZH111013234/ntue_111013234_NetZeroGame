// 開始畫面
class StartScreen {
  PImage backgroundImage; // 開始畫面的背景圖片
  int buttonWidth = 300; // 按鈕寬度
  int buttonHeight = 150; // 按鈕高度
  int buttonX, buttonY; // 按鈕位置
  String buttonText = "開始遊戲"; // 按鈕文字

  StartScreen() {
    // 初始化背景圖片
    backgroundImage = loadImage("img/background/start.jpg");
    // 設置按鈕位置
    buttonX = width / 6 - buttonWidth / 2;
    buttonY = height / 2 - buttonHeight / 2;
  }

  void display() {
    // 顯示背景圖片
    image(backgroundImage, 0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    // 顯示標題
    textSize(80);
    text("淨零排放小遊戲", width / 6, height / 6);
    textSize(36);

    fill(0, 255, 0);
    rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);
    fill(0);
    // 顯示按鈕文字
    text(buttonText, buttonX+buttonWidth / 2, buttonY+buttonHeight / 2);
  }

  void handleKeyPress() {
    if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight) {
      if (mousePressed) {
        mousePressed=false;
        game.gameStarted=true;
      }
    }
  }
}
