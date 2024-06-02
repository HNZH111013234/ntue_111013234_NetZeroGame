class LevelEatting extends Level {
  PImage cafeteriaImg, foodBgImg;
  PImage chopstickImg, foodImg, foodwareImg;

  BooleanWrapper isFoodware = new BooleanWrapper(false);

  BooleanWrapper isChopstick = new BooleanWrapper(false);
  BooleanWrapper foodPicked = new BooleanWrapper(false);

  LevelEatting() {
    cafeteriaImg = loadImage("img/background/cafeteria.png");
    foodBgImg = loadImage("img/background/foodBg.jpg");
    chopstickImg=loadImage("img/chopstick.png");
    foodImg=loadImage("img/food.png");
    foodwareImg=loadImage("img/foodware.png");
  }

  void display() {
    if (currentPlace=="cafeteria") {
      image(cafeteriaImg, 0, navHeight, width, height);
      image(chopstickImg, 950, 700, 100, 100);
      image(goLeftImg, 10, screenHeight/2, 100, 100);

      if (isChopstick.value) image(incorrectImg, 950, 700, 100, 100);      
    }
    if (currentPlace=="table") {
      image(foodBgImg, 0, navHeight, width, height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);

      if (isFoodware.value) image(correctImg, 1400, 600, 300, 300);      
    }
    handleKeyPress();
  }
  void handleKeyPress() {
    if (currentPlace == "cafeteria") {
      moveDetect("outside", 10, screenHeight/2, 110, screenHeight/2 + 100, "返回");
      interact(950, 700, 1050, 800, isChopstick, !isProgress, "incorrect.mp3",
        "台灣人每年共消耗約十億雙免洗筷子，約等同於砍去十萬棵竹子。一棵竹子一年約可吸收10公斤的二氧化碳，所以吃飯自備環保餐具能減少自己的碳足跡,小小習慣也可以為環境盡心力", "免洗筷", "");
      interact(500, 450, 1140, 680, foodPicked, !isProgress,"key.mp3", "選好菜後可以去座位了", "夾菜區", "食物餐盤");
      if (foodPicked.value) {
        moveDetect("table", 900, 400, 1900, 640, "座位");
      }
    }
    if (currentPlace == "table") {
      moveDetect("cafeteria", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "入口");
      interactWithTool(0, navHeight, width, height-200, isFoodware, isProgress, "chair.mp3", "使用環保餐具和環保袋減少一次性塑膠使用。每年可減少5kgCO2e，選擇環保餐具，為地球減少塑膠垃圾。", "午餐", "環保餐具", foodwareImg);
      if (isFoodware.value) {
        toolList.remove("食物餐盤");
      }
    }
  }
}
