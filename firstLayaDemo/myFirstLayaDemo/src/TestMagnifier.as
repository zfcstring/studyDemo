/*
 * @Author: Zhangfc 
 * @Date: 2019-09-05 15:03:34 
 * @Last Modified time: 2019-09-05 15:03:34 
 * @Title or Desc: 放大镜
 */
package {
  import laya.display.Sprite;
  import laya.display.Stage;
  import laya.utils.Browser;
  import laya.utils.Handler;
  import laya.webgl.WebGL;

  public class TestMagnifier {
    private var Bigbg:Sprite; // 放大图
    private var maskSp:Sprite; // 放大镜

    public function TestMagnifier() {
      // 初始化舞台,不支持WebGL,自动切换问canvas
      Laya.init(1136, 640, WebGL);
      Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
      Laya.stage.scaleMode = "showall";
      Laya.stage.bgColor = "#232628";
      Laya.loader.load("testImg/bgImg.jpg", Handler.create(this, setup));
    }

    private function setup(_e:*=null):void {
      // 加载正常图片
      var bg:Sprite = new Sprite();
      bg.loadImage("testImg/bgImg.jpg");
      Laya.stage.addChild(bg);
      // 设置放大后的图片
      Bigbg = new Sprite();
      Bigbg.loadImage("testImg/bgImg.jpg");
      Laya.stage.addChild(Bigbg);
      Bigbg.scale(3, 3);
      // 创建mask
      maskSp = new Sprite();
      maskSp.loadImage("testImg/test002.png");
      maskSp.pivot(50, 50);
      // 设置mask
      Bigbg.mask = maskSp;
      // 添加鼠标事件
      Laya.stage.on("mousemove", this, onMouseMove);
    }
    private function onMouseMove(_e:*=null):void {
      var x:int = Laya.stage.mouseX <= 1136 ? Laya.stage.mouseX : 0;
      var y:int = Laya.stage.mouseY <= 640 ? Laya.stage.mouseY : 0;
      Bigbg.x = -x * 2;
      Bigbg.y = -y * 2;
      maskSp.x = x;
      maskSp.y = y;
    }
  }
}