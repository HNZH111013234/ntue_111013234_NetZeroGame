class EndScreen {
  String QNRUrl = "https://forms.gle/q4KBriHxDAoi1GUT6";
  PImage backgroundImage, mindmapImg, QNRImg; // 開始畫面的背景圖片
  int buttonWidth = 300; // 按鈕寬度
  int buttonHeight = 150; // 按鈕高度
  int buttonX, buttonY; // 按鈕位置
  String buttonText = "再玩一次"; // 按鈕文字

  EndScreen() {
    // 初始化背景圖片
    backgroundImage = loadImage("img/background/end.jpg");
    mindmapImg = loadImage("img/mindmap.png");
    QNRImg = loadImage("img/QNR.png");
    // 設置按鈕位置
    buttonX = width / 6 - buttonWidth / 2;
    buttonY = height / 2 - buttonHeight / 2;
  }

  void display() {
    // 顯示背景圖片
    image(backgroundImage, 0, 0, width, height);
    image(mindmapImg, 1120, 0, 800, 1050);
    image(QNRImg, buttonX, buttonY+250, 600,300);
    fill(255);
    textAlign(CENTER, CENTER);
    // 顯示標題
    textSize(80);
    fill(107, 142, 35);
    text("恭喜完成 感謝您的遊玩", width / 6+250, height / 6+50);
    textSize(32);
    text("點擊下方圖片可以填寫問卷", width / 6+50, buttonY+225);
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
        game.gameStarted=false;
        game.gameOver=false;
      }
    }
    if (mouseX >= buttonX && mouseX <= buttonX + 600 && mouseY >= buttonY+250 && mouseY <= buttonY + 550) {
      if (mousePressed) {
        mousePressed=false;
        openLink(QNRUrl);
      }
    }
  }
}
