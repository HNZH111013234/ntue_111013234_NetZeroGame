ArrayList<String>toolList;
String choosedItem="";
boolean toolUsed=false;
class ToolBar extends Level {
  int barHeight = 100, barWidth = 100, toolBarX = width / 2 - 350, toolBarY = screenHeight - barHeight;
  int toolPage=1, capacity=0, gap=0;
  int choosedX=-100, choosedY=-100;
  BooleanWrapper choosed = new BooleanWrapper(false);
  BooleanWrapper isAlt = new BooleanWrapper(false);


  ToolBar() {
    toolList = new ArrayList<String>();
  }

  void display() {
    stroke(218, 165, 32);
    fill(255);
    for (int i=0; i<7; i++) {
      rect(toolBarX + barWidth * i, toolBarY, barWidth, barHeight);
    }
    image(altImg, toolBarX + barWidth * 7, toolBarY, barWidth, barHeight);
    interact(toolBarX + barWidth * 7, toolBarY, toolBarX + barWidth * 8, toolBarY+barHeight, isAlt, !isProgress, "beep.mp3",
      "切換", "切換", "");

    if (toolPage==1) {
      gap=0;
      if (isAlt.value) {
        if (toolList.size()>6) {
          toolPage=2;
        }
        isAlt.value=false;
      }
    } else {
      gap=7;
      if (isAlt.value) {
        toolPage=1;
        isAlt.value=false;
      }
    }

    PImage tool;
    int capacity=0;
    for (int i = 0; i < toolList.size(); i++) {
      switch (toolList.get(i)) {
      case "環保餐具":
        tool = levelHouse.foodwareImg;
        break;
      case "冷氣遙控器":
        tool = levelHouse.controllerImg;
        break;
      case "省水裝置":
        tool = levelHouse.watersaveImg;
        break;
      case "購物袋":
        tool = levelHouse.bagImg;
        break;
      case "一袋回收":
        tool=levelHouse.trashImg;
        break;
      case "汽車鑰匙":
        tool=levelHouse.carKeyImg;
        break;
      case "機車鑰匙":
        tool=levelHouse.motorKeyImg;
        break;
      case "板手":
        tool=levelHouse.wrenchImg;
        break;
      case "手機":
        tool=levelHouse.phoneImg;
        break;
      case "剛洗好的衣服":
        tool=levelHouse.laundryImg;
        break;
      case "保鮮盒":
        tool=levelHouse.cripserImg;
        break;
      case "食物餐盤":
        tool=levelEatting.foodImg;
        break;
      case "蔬果籃":
        tool=vegGame.vegBasketImg;
        break;
      case "肉品籃":
        tool=meatGame.meatBasketImg;
        break;
      case "日用品籃":
        tool=shelfGame.shelfBasketImg;
        break;
      case "旅遊指南:請從家裡找出新產生的三項旅遊相關的環保用品，然後走出家門":
        tool=levelHouse.guidebookImg;
        break;
      case "行李":
        tool=levelHouse.baggageImg;
        break;
      default:
        tool = null;
        break;
      }
      if (tool != null) {
        if (gap>0) {
          gap--;
        } else if (capacity<7) {
          interact(toolBarX + barWidth * capacity, toolBarY, toolBarX+barWidth*(capacity+1), toolBarY+barHeight, choosed, !isProgress, "", toolList.get(i), toolList.get(i), "");
          if (choosed.value) {
            choosedX=toolBarX + barWidth * capacity;
            choosedY=toolBarY;
            choosedItem=toolList.get(i);
            choosed.value=false;
            toolUsed=false;
          }
          image(tool, toolBarX + barWidth * capacity, toolBarY, barWidth, barHeight);
          capacity++;
        }
      }
    }
    if (!toolUsed) {
      fill(128, 128, 128, 128);
      rect( choosedX, choosedY, barWidth, barHeight);
      fill(255);
    }
  }
}
