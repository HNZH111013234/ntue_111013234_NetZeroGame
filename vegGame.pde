class VegGame extends Level {
  PImage basketImg, vegBasketImg, bg, instruction1Img, instruction2Img, instruction3Img;
  PImage[] itemImgs = new PImage[16]; // 假設有3種不同的物品
  String[] itemPath=new String[]{"絲瓜", "cabbage", "冬瓜", "eggplant", "mango", "orange", "peach",
    "pumpkin", "redbean", "strawberry", "watermelon", "whiteRadish", "小白菜", "龍眼", "哈密瓜", "棗子"};
  String[] summerVegs=new String[]{"絲瓜", "龍眼", "eggplant", "mango", "peach",
    "pumpkin", "watermelon", "冬瓜"};
  ArrayList<Item> items = new ArrayList<Item>();
  int score = 0, page=1;

  boolean haveFinished=false;
  VegGame() {
    basketImg = loadImage("img/miniGame/vegGame/basket.png");
    vegBasketImg=loadImage("img/miniGame/vegGame/basketAfter.png");
    instruction1Img = loadImage("img/miniGame/vegGame/instruction1.png");
    instruction2Img = loadImage("img/miniGame/vegGame/instruction2.png");
    instruction3Img = loadImage("img/miniGame/vegGame/instruction3.png");
    bg = loadImage("img/miniGame/vegGame/vegGameBg.jpeg");
    for (int i = 0; i < itemImgs.length; i++) {
      itemImgs[i] = loadImage("img/miniGame/vegGame/"+itemPath[i] + ".png");
    }
  }
  class Item {
    PImage img;
    float x, y, speed = 5;
    String name;

    Item(PImage img, float x, float y, String name) {
      this.img = img;
      this.x = x;
      this.y = y;
      this.name=name;
    }
    void update() {
      y += speed;
    }
    void display() {
      image(img, x, y, img.width, img.height);
    }

    boolean collidesWithBasket(float basketX, float basketY) {
      // 碰撞檢測
      if (x + img.width >= basketX && x <= basketX + basketImg.width &&
        y + img.height >= basketY && y <= basketY + basketImg.height) {
        return true;
      }
      return false;
    }
  }

  void display() {
    if (currentPlace=="veg instruction") {
      narColor=color(0, 139, 69);
      narration="按滑鼠左鍵到下一頁，右鍵跳過說明";
      if (page==1) {
        image(instruction1Img, 0, navHeight, width, height);
      } else if (page==2) {
        image(instruction2Img, 0, navHeight, width, height);
      } else if (page==3) {
        image(instruction3Img, 0, navHeight, width, height);
      }
    } else if (currentPlace=="veg game") {
      narColor=color(0, 139, 69);
      narration="左右鍵移動，接到夏季蔬果加20分，冬季蔬果扣20分，達到100分則完成";
      image(bg, 0, navHeight, width, height);
      image(basketImg, mouseX - basketImg.width/2, height - basketImg.height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      if (frameCount % (frameRate*0.9) == 0) { // 每秒掉落一次
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

        if (item.collidesWithBasket(mouseX, height - basketImg.height)) {
          boolean isScore=false;
          for (String summerVeg : summerVegs) {
            if (summerVeg==item.name) {
              score+=20;
              isScore=true;
            }
          }
          if (!isScore) {
            score-=20;
          }
          items.remove(i); // 接住物品後從列表中移除
        } else if (item.y > height+50) {
          items.remove(i); // 物品掉到畫面底部未被接住，從列表中移除
        }
      }
      fill(0);
      text("Score: " + score, 10, navHeight+20);

      if (score==100) {
        score=0;
        currentPlace="veg zone";
        currentMusic="bg.mp3";
        bgMusic.close();
        bgMusic = minim.loadFile("/music/bg.mp3");
        bgMusic.loop();
        boolean duplicate=false;
        for (String tool : toolList) {
          if (tool=="蔬果籃") duplicate=true;
        }
        if (!duplicate) {
          toolList.add("蔬果籃");
        }
        if (!haveFinished) {
          progress++;
          haveFinished=true;
        }
      }
    }
    handleKeyPress();
  }
  void handleKeyPress() {
    if (currentPlace == "veg game") {
      moveDetect("veg zone", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "退出", "bg.mp3");
    } else if (currentPlace == "veg instruction") {
      if (mousePressed&&mouseButton==LEFT) {
        mousePressed=false;
        page+=1;
        if (page>3) {
          currentPlace ="veg game";
          page=1;
        }
      } else if (mousePressed&&mouseButton==RIGHT) {
        mousePressed=false;
        currentPlace ="veg game";
        page=1;
      }
    }
  }
}
