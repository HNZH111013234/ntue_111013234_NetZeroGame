class MeatGame extends Level {
  PImage basketImg, meatBasketImg, bg, instruction1Img, instruction2Img;
  PImage[] itemImgs = new PImage[8];
  String[] itemPath=new String[]{"chicken", "cow", "egg", "fish", "mutton", "pig", "shrimp", "steak"};
  String[] lightMeats=new String[]{"chicken", "egg", "fish", "pig", "shrimp"};
  ArrayList<Item> items = new ArrayList<Item>();
  int score = 0, page=1;
  float angle = 0;
  float basketSpeedX = 0;
  float basketSpeedY = 0;
  float basketX=0, basketY=0;
  boolean haveFinished=false;
  Basket basket;

  MeatGame() {
    basketImg=loadImage("img/miniGame/meatGame/basket.png");
    meatBasketImg=loadImage("img/miniGame/meatGame/basketAfter.png");
    basket = new Basket(basketImg, width / 2, height / 2);
    instruction1Img = loadImage("img/miniGame/meatGame/instruction1.png");
    instruction2Img = loadImage("img/miniGame/meatGame/instruction2.png");
    bg = loadImage("img/miniGame/meatGame/meatGameBg.jpg");
    for (int i = 0; i < itemImgs.length; i++) {
      itemImgs[i] = loadImage("img/miniGame/meatGame/"+itemPath[i] + ".png");
    }
  }
  class Item {
    PImage img;
    float x, y, speedX, speedY;
    String name;
    int bounce;

    Item(PImage img, float x, float y, String name) {
      this.img = img;
      this.x = x;
      this.y = y;
      this.name=name;
      this.bounce=0;
      this.speedX=random(-5, 5);
      this.speedY=random(-5, 5);
    }
    void update() {
      x += speedX;
      y += speedY;

      if (x < 0 || x > width-50) {
        bounce++;
        speedX *= -1; // 反彈
      }
      if (y < 0 || y > height-50) {
        bounce++;
        speedY *= -1; // 反彈
      }
    }
    void display() {
      image(img, x, y, 100, 100);
    }

    boolean collidesWithBasket(float basketX, float basketY) {
      // 碰撞檢測
      if (x + img.width >= basketX && x <= basketX + basketImg.width &&
        y + img.height >= basketY && y <= basketY + basketImg.height) {
        return true;
      }
      return false;
    }

    boolean disappear() {
      if (bounce>1) {
        return true;
      }
      return false;
    }
  }
  class Basket {
    PImage img; // 圖片
    float x, y; // 位置
    float speed = 5; // 移動速度

    Basket(PImage img, float x, float y) {
      this.img = img;
      this.x = x;
      this.y = y;
    }

    void move(float dx, float dy) {
      x += dx;
      y += dy;
      x = constrain(x, 0, width - img.width);
      y = constrain(y, 0, height - img.height);
    }

    void display() {
      basketX=x;
      basketY=y;
      pushMatrix(); // 保存當前的轉換狀態
      translate(x + img.width / 2, y + img.height / 2); // 將座標系移動到籃子的中心點
      rotate(angle - PI / 2); // 旋轉
      image(img, -img.width / 2, -img.height / 2, img.width, img.height); // 將籃子繪製到旋轉後的位置
      popMatrix(); // 恢復原來的轉換狀態
    }
  }
  void display() {
    if (currentPlace=="meat instruction") {
      narColor=color(0, 139, 69);
      narration="按滑鼠左鍵到下一頁，右鍵跳過說明";
      if (page==1) {
        image(instruction1Img, 0, navHeight, width, height);
      } else if (page==2) {
        image(instruction2Img, 0, navHeight, width, height);
      }
    } else if (currentPlace=="meat game") {
      narColor=color(0, 139, 69);
      narration="滑鼠控制朝向，上下左右鍵移動，接到中低碳排食物加20分，高碳排食物扣20分，達到100分則完成";
      image(bg, 0, navHeight, width, height);
      basket.move(basketSpeedX, basketSpeedY);
      basket.display();

      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      if (frameCount % (frameRate*1) == 0) { // 每秒掉落一次
        int randomIndex = int(random(itemImgs.length)); // 隨機選擇一種物品
        PImage randomItemImg = itemImgs[randomIndex];
        Item newItem = new Item(randomItemImg, random(width), 0, itemPath
          [randomIndex]); // 在畫面頂部隨機位置生成物品
        items.add(newItem);
      }
      // 更新和顯示物品
      for (int i = items.size() - 1; i >= 0; i--) {
        Item item = items.get(i);
        item.update();
        item.display();
        if (item.disappear()) {
          items.remove(i);
        }
        if (item.collidesWithBasket(basketX, basketY)) {
          boolean isScore=false;
          for (String lightMeat : lightMeats) {
            if (lightMeat==item.name) {
              score+=20;
              isScore=true;
            }
          }
          if (!isScore) {
            score-=20;
          }
          items.remove(i); // 接住物品後從列表中移除
        }
      }
      fill(255);
      text("Score: " + score, 10, navHeight+20);
    }

    if (score==100) {
      score=0;
      currentPlace="meat zone";
      currentMusic="bg.mp3";
      bgMusic.close();
      bgMusic = minim.loadFile("/music/bg.mp3");
      bgMusic.loop();
      boolean duplicate=false;
      for (String tool : toolList) {
        if (tool=="肉品籃") duplicate=true;
      }
      if (!duplicate) {
        toolList.add("肉品籃");
      }
      if (!haveFinished) {
        progress++;
        haveFinished=true;
      }
    }
    handleKeyPress();
  }
  void handleKeyPress() {
    if (currentPlace == "meat game") {
      moveDetect("meat zone", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "退出", "bg.mp3");
      if (keyPressed) {
        keyPressed=false;
        if (keyCode == LEFT) {
          basketSpeedX = -basket.speed;
        } else if (keyCode == RIGHT) {
          basketSpeedX = basket.speed;
        } else if (keyCode == UP) {
          basketSpeedY = -basket.speed;
        } else if (keyCode == DOWN) {
          basketSpeedY = basket.speed;
        }
      }
      float dx = mouseX - basket.x - basket.img.width / 2;
      float dy = mouseY - basket.y - basket.img.height / 2;
      angle = atan2(dy, dx);
    } else if (currentPlace == "meat instruction") {
      if (mousePressed&&mouseButton==LEFT) {
        mousePressed=false;
        page+=1;
        if (page>2) {
          currentPlace ="meat game";
          page=1;
        }
      } else if (mousePressed&&mouseButton==RIGHT) {
        mousePressed=false;
        currentPlace ="meat game";
        page=1;
      }
    }
  }
}
