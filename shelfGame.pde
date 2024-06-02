class ShelfGame extends Level {
  PImage bg, instruction1Img, instruction2Img, instruction3Img, shelfBasketImg;
  PImage[] cardImages = new PImage[16];
  int[] itemPath=new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
  int[][] board = new int[4][4];
  boolean[][] revealed = new boolean[4][4];
  int firstCardX, firstCardY, secondCardX, secondCardY, revealedCount = 0;
  float time=0;
  boolean cal=false, shuffled=false;
  int score = 0, page=1;

  boolean haveFinished=false;
  ShelfGame() {
    instruction1Img = loadImage("img/miniGame/shelfGame/instruction1.png");
    instruction2Img = loadImage("img/miniGame/shelfGame/instruction2.png");
    instruction3Img = loadImage("img/miniGame/shelfGame/instruction3.png");
    bg = loadImage("img/miniGame/shelfGame/shelf.png");
    shelfBasketImg=loadImage("img/miniGame/shelfGame/basketAfter.png");
    for (int i = 0; i < cardImages.length; i++) {
      cardImages[i] = loadImage("img/miniGame/shelfGame/"+String.valueOf(itemPath[i]) + ".png");
    }
  }
  int[] shuffleArray(int[] array) {
    int[] newArray = array.clone();
    for (int i = newArray.length - 1; i > 0; i--) {
      int index = (int) random(i + 1);
      int temp = newArray[index];
      newArray[index] = newArray[i];
      newArray[i] = temp;
    }
    return newArray;
  }
  void initializeBoard(boolean isShuffled) {
    if (!isShuffled) {
      int[] shuffledImages = shuffleArray(itemPath);
      int index = 0;
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          board[i][j] = shuffledImages[index];
          index++;
          revealed[i][j] = false;
        }
      }
    }
    shuffled=true;
  }
  void drawBoard() {
    stroke(0);
    if (!cal) {
      time=frameCount/frameRate;
    }
    if ((frameCount/frameRate)-time>2) {
      revealed[firstCardX][firstCardY] = false;
      revealed[secondCardX][secondCardY] = false;
      cal=false;
    }
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (revealed[i][j]) {
          image(cardImages[board[i][j] - 1], 65 + i * 465, 80+j * 250, 400, 200);
        } else {
          fill(100);
          rect(65 + i * 465, 80 + j * 250, 400, 200);
        }
      }
    }
  }
  void display() {
    if (currentPlace=="shelf instruction") {
      narColor=color(0, 139, 69);
      narration="按滑鼠左鍵到下一頁，右鍵跳過說明";
      if (page==1) {
        image(instruction1Img, 0, navHeight, width, height);
      } else if (page==2) {
        image(instruction2Img, 0, navHeight, width, height);
      } else if (page==3) {
        image(instruction3Img, 0, navHeight, width, height);
      }
    } else if (currentPlace=="shelf game") {
      narColor=color(0, 139, 69);
      narration="翻開兩張相同標章介紹的卡牌則形成配對，全部配對完即完成";
      image(bg, 0, navHeight, width, height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      initializeBoard(shuffled);
      drawBoard();
    }
    handleKeyPress();
  }
  void handleKeyPress() {
    if (currentPlace == "shelf game") {
      moveDetect("grocery store", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "退出", "bg.mp3");
      if (mousePressed&&mouseY>80) {
        mousePressed=false;
        int x = mouseX/ 465;
        int y = mouseY / 250;
        if (x < 4 && y < 4 && !revealed[x][y]&&!cal) {
          revealed[x][y] = true;

          if (revealedCount == 0) {
            firstCardX = x;
            firstCardY = y;
          } else {
            cal=true;
            secondCardX=x;
            secondCardY=y;
            if (board[x][y]%2==0&&board[x][y]-1==board[firstCardX][firstCardY]) {
              cal=false;
              score+=1;
              soundEffect=minim.loadFile("/music/correct.mp3");
              try {
                soundEffect.play();
              }
              catch (NullPointerException e) {
              }
            }
            if (board[x][y]%2!=0&&board[x][y]+1==board[firstCardX][firstCardY]) {
              cal=false;
              score+=1;
              soundEffect=minim.loadFile("/music/correct.mp3");
              try {
                soundEffect.play();
              }
              catch (NullPointerException e) {
              }
            }
          }
          revealedCount++;
          if (revealedCount == 2) {
            revealedCount = 0;
          }
          if (score==8) {
            score=0;
            shuffled=false;
            currentPlace="grocery store";
            currentMusic="bg.mp3";
            bgMusic.close();
            bgMusic = minim.loadFile("/music/bg.mp3");
            bgMusic.loop();
            boolean duplicate=false;
            for (String tool : toolList) {
              if (tool=="日用品籃") duplicate=true;
            }
            if (!duplicate) {
              toolList.add("日用品籃");
            }
            if (!haveFinished) {
              progress++;
              haveFinished=true;
            }
          }
        }
      }
    } else if (currentPlace == "shelf instruction") {
      if (mousePressed&&mouseButton==LEFT) {
        mousePressed=false;
        page+=1;
        if (page>3) {
          currentPlace ="shelf game";
          page=1;
        }
      } else if (mousePressed&&mouseButton==RIGHT) {
        mousePressed=false;
        currentPlace ="shelf game";
        page=1;
      }
    }
  }
}
