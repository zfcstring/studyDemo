/*
 * @Author: Zhangfc 
 * @Date: 2019-09-04 15:30:15 
 * @Last Modified time: 2019-09-04 16:05:38
 * @Title or Desc: 图片随机下降旋转
 */
package {
  import laya.display.Sprite;
  import laya.display.Stage;
  import laya.ui.Image;
  import laya.utils.Pool;
  import laya.utils.Stat;
  import laya.webgl.WebGL;

  public class TestDown {
    // 创建时间对象
    private var createTime:int = 0;

    public function TestDown() {
      // 初始化引擎, 不支持WebGL自动切换为cavas
      Laya.init(1136, 640, WebGL);
      // 等比缩放
      Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
      Laya.stage.bgColor = "#232628";
      //帧循环
      Laya.timer.frameLoop(1, this, onFrame);
      Stat.show(0, 0);
    }

    // 每100帧创建100个测试对象
    private function onFrame():void {
      // 100帧后
      if (createTime >= 100) {
        // 每100帧创建100个测试对象
        for (var i:int = 0; i < 100; i++) {
          // img:Image = new Image(); //不使用对象池的写法                  
          // 通过对象池创建图片，如对象池中无相应的对象，则根据Image类型执行new Image()创建
          var img:Image = Pool.getItemByClass("img", Image);
          // 通过瞄点设置轴心点
          img.anchorX = img.anchorY = 0.5;
          // 图片的资源
          img.skin = "testImg/test002.png";
          // 在舞台上方随机创建位置
          img.x = Math.random() * 1136;
          img.y = Math.random() * -150;
          // 如果对象中还有其他属性被改变了，需重新设置
          // 对象池中的图片被缩放了，需重新设置其缩放属性。
          img.scaleX = img.scaleY = 1;
          // 加载到舞台
          Laya.stage.addChild(img);
        }
        createTime = 0;
      } else {
        createTime++;
      }

      // 每个舞台中的图片对象，进行位置更新。
      // 检测对象是否超出边界或者缩放到0了
      for (var j:int = 0; j < Laya.stage.numChildren; j++) {
        // 获取舞台中的图片对象
        var img1:Image = Laya.stage.getChildAt(j) as Image;
        // 位置更新
        img1.y++;
        // 缩放更新
        img1.scaleX -= 0.001;
        img1.scaleY -= 0.001;
        // 图片旋转
        img1.rotation++;
        // 判断是否移除回收
        if (img1.y > 640 + 20 || img1.scaleX <= 0) {
          // 从舞台移除
          Laya.stage.removeChild(img1);
          // img1.destroy(); //不使用对象池的编写方式,直接用destroy清空             
          // 回收到对象池
          Pool.recover("img",img1)
        }
      }
    }
  }
}