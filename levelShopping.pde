class LevelShopping extends Level {
  PImage groceryStoreImg, meatZoneImg, vegZoneImg, counterImg, vegBasketImg, meatBasketImg, shelfBasketImg,
    bagImg, phoneImg;
  int question=1;
  String questionText;
  BooleanWrapper isGrocery = new BooleanWrapper(false);
  BooleanWrapper isVeg = new BooleanWrapper(false);
  BooleanWrapper isMeat = new BooleanWrapper(false);
  BooleanWrapper isShelf = new BooleanWrapper(false);
  BooleanWrapper isCheckout = new BooleanWrapper(false);
  BooleanWrapper isBag = new BooleanWrapper(false);
  BooleanWrapper isPhonePay = new BooleanWrapper(false);
  BooleanWrapper isWrap = new BooleanWrapper(false);
  BooleanWrapper isWrong = new BooleanWrapper(false);
  BooleanWrapper isPreserve = new BooleanWrapper(false);

  LevelShopping() {
    groceryStoreImg = loadImage("img/background/groceryStore.png");
    vegZoneImg = loadImage("img/background/vegZone.png");
    meatZoneImg = loadImage("img/background/meatZone.jpg");
    counterImg = loadImage("img/background/counter.jpg");
    vegBasketImg = loadImage("img/miniGame/vegGame/basketAfter.png");
    meatBasketImg = loadImage("img/miniGame/meatGame/basketAfter.png");
    shelfBasketImg = loadImage("img/miniGame/shelf/basketAfter.png");
    bagImg = loadImage("img/bag.png");
    phoneImg = loadImage("img/phone.png");
  }

  void display() {
    switch(currentPlace) {
    case "grocery store":
      image(groceryStoreImg, 0, navHeight, width, height);
      image(goRightImg, 1810, screenHeight/2, 100, 100);
      image(goUpImg, screenWidth/2-50, navHeight+10, 100, 100);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      break;
    case "veg zone":
      image(vegZoneImg, 0, navHeight, width, height);
      image(goDownImg, screenWidth/2-50, screenHeight-180, 100, 100);
      break;
    case "meat zone":
      image(meatZoneImg, 0, navHeight, width, height);
      image(goLeftImg, 10, screenHeight/2, 100, 100);
      break;
    case "grocery store entrance":
      image(counterImg, 0, navHeight, width, height);
      image(goRightImg, 1810, screenHeight/2, 100, 100);
      image(goLeftImg, 10, screenHeight/2, 100, 100);
      if (isBag.value&&isPhonePay.value&&isWrap.value) {
        image(correctImg, 500, 250);
      }
      break;
    default:
      // 如果 currentPlace 不符合任何已知情境時的預設情況
      break;
    }

    handleKeyPress();
  }
  void handleKeyPress() {
    switch(currentPlace) {
    case "grocery store":
      moveDetect("veg zone", screenWidth/2 - 50, navHeight + 10, screenWidth/2 + 50, navHeight + 110, "蔬果區");
      moveDetect("meat zone", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "肉品區");
      moveDetect("grocery store entrance", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "出口");
      moveDetect("shelf instruction", 30, 90, 720, 670, "商品架", "shelfBg.mp3");
      break;
    case "veg zone":
      moveDetect("grocery store", screenWidth/2 - 50, screenHeight - 180, screenWidth/2 + 50, screenHeight - 80, "入口");
      moveDetect("veg instruction", 0, 610, 1920, 1050, "挑選適合的蔬果", "vegBg.mp3");
      break;
    case "meat zone":
      moveDetect("grocery store", 10, screenHeight/2, 110, screenHeight/2 + 100, "入口");
      moveDetect("meat instruction", 1000, 700, 1920, 900, "挑選適合的肉類", "meatBg.mp3");
      moveDetect("meat instruction", 0, 200, 750, 750, "挑選適合的肉類", "meatBg.mp3");
      break;
    case "grocery store entrance":
      moveDetect("outside", 10, screenHeight/2, 110, screenHeight/2 + 100, "外面");
      moveDetect("grocery store", 1810, screenHeight/2, 1910, screenHeight/2 + 100, "走道");
      if (!isCheckout.value) {
        if (!isVeg.value||!isMeat.value||!isShelf.value) {
          questionText="請完成三個小遊戲後再來結帳";
          stroke(0);
          rect(300, 200, 500, 50);
          fill(0);
          text(questionText, 300, 225);
          fill(255);
          if (choosedItem!="") {
            switch (choosedItem) {
            case "蔬果籃":
              interactWithTool(300, 250, 1600, 800, isVeg, !isProgress, "beep.mp3", "結帳櫃檯", "結帳櫃檯", "蔬果籃", vegBasketImg);
            case "肉品籃":
              interactWithTool(300, 250, 1600, 800, isMeat, !isProgress, "beep.mp3", "結帳櫃檯", "結帳櫃檯", "肉品籃", meatBasketImg);
            case "日用品籃":
              interactWithTool(300, 250, 1600, 800, isShelf, !isProgress, "beep.mp3", "結帳櫃檯", "結帳櫃檯", "日用品籃", shelfBasketImg);
            }
          }
        } else if (question==1) {
          questionText="請問需要買購物袋嗎";
          rect(300, 200, 500, 50);
          fill(0);
          text(questionText, 300, 225);
          fill(255);
          rect(1000, 500, 50, 50);
          fill(0);
          text("好", 1000, 525);
          fill(255);
          rect(1100, 500, 400, 50);
          fill(0);
          text("(拿出購物袋)", 1100, 525);
          fill(255);
          interact(1000, 500, 1050, 550, isWrong, !isProgress, "incorrect.mp3", "好", "好", "");
          interactWithTool(300, 250, 1600, 800, isBag, isProgress, "correct.mp3",
            "根據統計塑膠袋每年使用量高達180億個，平均每人每年使用量高達782個，使用1個塑膠袋會產生57公克二氧化碳排放量，自備購物袋，為地球減少塑膠垃圾。", "請問需要買購物袋嗎?", "購物袋", bagImg);
          if (isWrong.value) {
            question++;
            isWrong.value=false;
          }
          if (isBag.value) {
            question++;            
          }
        } else if (question==2) {
          questionText="請問要用電子載具還是付現?";
          rect(300, 200, 500, 50);
          fill(0);
          text(questionText, 300, 225);
          fill(255);
          rect(1000, 500, 50, 50);
          fill(0);
          text("好", 1000, 525);
          fill(255);
          rect(1100, 500, 400, 50);
          fill(0);
          text("(拿出手機)", 1100, 525);
          fill(255);
          interact(1000, 500, 1050, 550, isWrong, !isProgress, "incorrect.mp3", "好", "好", "");
          interactWithTool(300, 250, 1600, 800, isPhonePay, isProgress, "correct.mp3",
            "電子發票減少紙張使用，減少碳排放。每年可減少0.2kgCO2e，方便又環保，邁向無紙化結帳。", "請問要用電子載具還是付現?", "手機", phoneImg);
          if (isWrong.value) {
            question++;
            isWrong.value=false;
          }
          if (isPhonePay.value) {
            question++;            
          }
        } else if (question==3) {
          questionText="請問您這個禮盒需要額外包裝嗎?";
          fill(255);
          rect(300, 200, 500, 50);
          fill(0);
          text(questionText, 300, 225);
          fill(255);
          rect(1000, 500, 50, 50);
          fill(0);
          text("好", 1000, 525);
          fill(255);
          rect(1100, 500, 400, 50);
          fill(0);
          text("不用了謝謝", 1100, 525);
          fill(255);
          interact(1000, 500, 1050, 550, isWrong, !isProgress, "incorrect.mp3", "好", "好", "");
          interact(1100, 500, 1500, 550, isWrap, isProgress, "correct.mp3", "不用了謝謝", "不用了謝謝", "");
          if (isWrong.value) {
            question++;
            isWrong.value=false;
          }
          if (isWrap.value) {
            question++;
            narColor=color(0, 139, 69);
            narration="選擇無包裝或簡約包裝商品，每年可減少20kgCO2e。減少包裝，輕量化生活，為地球減少不必要的塑膠垃圾。";
          }
        } else if (!isBag.value||!isPhonePay.value) {
          questionText="請找到手機和環保袋後交上來，可以補上進度";
          fill(255);
          rect(300, 200, 500, 50);
          fill(0);
          text(questionText, 300, 225);
          
          rect(1000, 500, 200, 50);
          fill(0);
          text("再試一次", 1000, 525);          
          interact(1000, 500, 1200, 550, isWrong, !isProgress, "", "再試一次", "選擇無包裝或簡約包裝商品，每年可減少20kgCO2e。減少包裝，輕量化生活，為地球減少不必要的塑膠垃圾。", "");
          if (isWrong.value) {
            question=1;
            isWrong.value=false;
          }
        } else {
          isCheckout.value=true;
        }
      }
    }
  }
}
