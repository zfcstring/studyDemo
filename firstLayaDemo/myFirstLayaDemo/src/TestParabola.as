/*
 * @Author: Zhangfc 
 * @Date: 2019-09-05 08:47:51 
 * @Last Modified time: 2019-09-05 10:12:21
 * @Title or Desc: 抛物线模型
 */
package {
  import laya.display.Sprite;
  import laya.display.Stage;
  import laya.ui.Image;
  import laya.utils.pool;
  import laya.utils.Stat;
  import laya.webgl.WebGL;

  public class TestParabola {
    // 判断抛物线是否完成
    private var isFinshed:Boolean = true
    private var img:Image;

    public function TestParabola() {
      // 初始化引擎, 不支持WebGL自动切换为canvas
      Laya.init(1280, 640, WebGL);
      Stat.show(0, 0);
      // 舞台背景色
      Laya.stage.bgColor = "#232628";
      //帧循环
      Laya.timer.frameLoop(1, this, onFrame);
    }

    // 创建抛物线运动对象
    private function onFrame():void {
      if (isFinshed) {
        img = new Image();
        // 通过瞄点设置轴心点
        img.anchorX = img.anchorY = 0.5;
        // 图片的资源
        img.skin = "testImg/paper-plane.png";
        // 图片的初始位置
        img.x = 0;
        img.y = 640;
        // 初始角度
        img.rotation = 45;
        // 加载到舞台
        Laya.stage.addChild(img);
        isFinshed = false;
      }

      // 每个舞台中的图片对象，进行位置更新。并判断本次抛物线是否完成了
      /*
        y = a*x^2 + b*x + c; (0, 640), (320, 640), (160, 400)
        640 = c;
        640 = a * 320^2 + b*320 + 640; b = -320a; b = -2;
        0 = a * 160^2 + b*400 + 640; 160a - 2.5*320a = -4; a = 1 / 160
        y = 1/160 * x^2 - 2x + 640;
        y` = 1/80 * x - 2; y = -2x + 640; tanA = -2
        y1-y2 = 1/160 * (x1^2-x2^2) - 2(x1-x2) = 1/160 * (x1^2 - (x1-1)^2) - 2 = 1/160 * (2*x1 - 1) - 2
      */
      img.x++;
      img.y += (1/160) * (2 * img.x - 1) - 2;
      img.rotation = Math.atan((1/80) * img.x - 2) * 180/Math.PI + 135;
      if (img.x >= 320) {
        Laya.stage.removeChild(img);
        isFinshed = true;
      }
    }
  }
}