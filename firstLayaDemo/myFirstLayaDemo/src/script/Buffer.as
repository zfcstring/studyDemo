/*
 * @Author: Zhangfc 
 * @Date: 2019-09-20 10:23:31 
 * @Last Modified time: 2019-09-20 10:23:31 
 * @Title or Desc: buff盒子
 */
package script {
    import laya.components.Script;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.events.Event;
	import laya.media.SoundManager;
	import laya.physics.RigidBody;
	import laya.utils.Pool;
    import Bullet;
    /**
	 * 掉落buff盒子脚本，实现盒子碰撞及回收流程
	 */
    public class Buffer extends Script {
        /* buff持续时间 */
        private var buffTime:Number = 5 * 1000;
		/**刚体对象引用 */
		private var _rig:RigidBody;
        /* 是否获得了该buff */
        private var isGetBuff:Boolean = false;

        override public function onEnable():void {
			this._rig = this.owner.getComponent(RigidBody);
		}
        override public function onTriggerEnter(other:*,self:*,contact:*):void {
			var owner:Sprite = this.owner as Sprite;
            // 碰撞后，删除buff盒子，播放声音特效
            owner.removeSelf();
            SoundManager.playSound("sound/destroy.wav");
            trace("碰撞到的对象:", other);
            if (other.label === "buttle") {
				// 碰撞到子弹, 获得该BUFF
                setBuffStat(true);
			}
		}
        public function setBuffStat(stat:Boolean):void {
            this.owner.isGetBuff = stat;
        }
        override public function onDisable():void {
			// 盒子被移除时，回收盒子到对象池，方便下次复用，减少对象创建开销。
			Pool.recover("buffBox", this.owner);
		}
    }
}
