package script {
	import laya.components.Script;
	import laya.display.Sprite;
	import laya.physics.RigidBody;
	import laya.utils.Pool;
	
	/**
	 * 子弹脚本，实现子弹飞行逻辑及对象池回收机制
	 */
	public class Bullet extends Script {
		/* 子弹类型数组 普通子弹0, buff子弹1
		*type 子弹类型
		skin 子弹皮肤
		power 子弹攻击力
		 */
		public var curbulletId:int = 0;
		public var curBullet:Object;
		public var bullets:Array = [{
			id: 0,
			type: "普通",
			skin: "test/c2.png",
			power: 1
		}, {
			id: 1,
			type: "五角星",
			skin: "test/p1.png",
			power: 2
		}]
		// 初始化子弹
		override public function onEnable():void {
			// 设置初始速度
			var rig:RigidBody = this.owner.getComponent(RigidBody);
			rig.setVelocity({x: 0, y: -10});
			setBullet(curbulletId);
		}
		
		override public function onTriggerEnter(other:*,self:*,contact:*):void {
			//如果被碰到，则移除子弹
			this.owner.removeSelf();
		}
		
		override public function onUpdate():void {
			//如果子弹超出屏幕，则进行移除子弹
			if ((this.owner as Sprite).y < -10) {
				this.owner.removeSelf();
			}
		}
		
		override public function onDisable():void {
			//子弹被移除时，回收子弹到对象池，方便下次复用，减少对象创建开销
			Pool.recover("bullet", this.owner);
		}
		public function setBullet(id:int):void {
			// 设置子弹基础属性
			curBullet = bullets[id];	
		}
		public function getBullet(id:int):void {
			return curBullet;
		}
	}
}