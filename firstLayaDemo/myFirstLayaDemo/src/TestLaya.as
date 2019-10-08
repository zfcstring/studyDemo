/*
 * @Author: Zhangfc 
 * @Date: 2019-09-02 18:39:32 
 * @Last Modified time: 2019-09-05 16:03:23
 * @Title or Desc: 图片加载
 */
package {
  import laya.display.Text
  import laya.display.Sprite
  import laya.utils.Handler

  public class TestLaya {
    // 需要切换的图片地址
    private var img1:String = "testImg/test002.png";
    private var img2:String = "testImg/test003.png";
    // 切换状态
    private var flag:Boolean = false;
    private var img:Sprite;

    public function TestLaya() {
      // 创建舞台，默认背景色是黑色的
      Laya.init(1000, 600);
      // // 图片示例
      // TestImg();
      // 图片示例2
      TestdrawTextrue();
      // // 文本示例
      // TestTxt();
    }

    private function TestTxt():void {
      var txt:Text = new Text();
      // 设置文本内容
      txt.text = "Hello Layabox";
      // 设置文本颜色为白色，默认颜色为黑色
      txt.color = "#f00";
      // 文本字体大小
      txt.fontSize = 66;
      // 字体描边
      txt.stroke = 5; // 描边为5像素
      txt.strokeColor = "#fff"; // 描边颜色
      // 设置粗体
      txt.bold = true;
      // 是否斜体
      txt.italic = true;
      // 设置文本起点
      txt.pos(50, 60);
      // 设置舞台背景
      Laya.stage.bgColor = "#ddd";
      Laya.stage.addChild(txt);
    }

    private function TestImg():void {
      // 设置舞台背景
      Laya.stage.bgColor = "#fff";
      img = new Sprite()
      drawImg();
      // 设置监听事件
      img.on("click", this, drawImg);
    }
    private function drawImg():void {
      // 清空之前的图片
      img.graphics.clear();
      // 切换图片
      var imgUrl = (flag = !flag) ? img1 : img2;
      img.loadImage(imgUrl);
      // 将文本内容添加到舞台
      Laya.stage.addChild(img);
    }

    private function TestdrawTextrue():void {
      // 设置舞台背景色
      Laya.stage.bgColor = "#fff";
      // 先加载图片资源,然后通过回调方法绘制图片
      Laya.loader.load([img1, img2], Handler.create(this, graphicsImg));
    }
    private function graphicsImg():void {
      img = new Sprite();
      Laya.stage.addChild(img);
      ClickChangeImg();
      img.on("click", this, ClickChangeImg);
    }
    private function ClickChangeImg(e:* = null):void
    {
      img.graphics.clear();
      var imgUrl:String = (flag = !flag) ? img1 : img2;
      // 获取图片
      var texture:Texture = Laya.loader.getRes(imgUrl);
      // 绘制纹理
      img.graphics.drawTexture(texture);
      img.size(texture.width, texture.height);
    }
  }
}


