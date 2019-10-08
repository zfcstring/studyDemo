/*
 * @Author: Zhangfc 
 * @Date: 2019-09-05 16:06:08 
 * @Last Modified time: 2019-09-05 16:06:08 
 * @Title or Desc: 倒计时
 */
package {
  import laya.display.Text;
  import laya.display.Stage;
  import laya.webgl.WebGL;
  import laya.utils.Handler;
  import laya.utils.Tween;

  public class TestCountDown {
    var num:int = 3;

    public function TestCountDown() {
      // 初始化舞台
      Laya.init(1136, 640, WebGL);
      Laya.stage.bgColor = "#1b2436";
      Laya.stage.scaleMode = Stage.SCALE_NOSCALE;
      Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;

      // 创建倒计时文本
      CreateCount();
    }

    private function CreateCount():void {
      var txt:Text = new Text();
      txt.text = num;
      // txt.x = 500;
      // txt.y = 210;
      txt.align = "center";
      txt.color = "#fff";
      txt.font = "Impact";
      txt.fontSize = 50;
      Laya.stage.addChild(txt);
      Tween.to(txt, { fontSize: 200 }, 1000, null, Handler.create(this, changeSize, [txt]));
    }
    private function changeSize(txt:Text):void {
      if (num > 0) {
        num--;
      } else {
        num = 3;
      }
      Laya.stage.removeChild(txt)
      CreateCount();
    }
  }
}
