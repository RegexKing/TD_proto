package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerUnit extends FlxSprite
	{
		private const FIRE_RANGE:int = 250;
		
		private var enemyGroup:FlxGroup;
		private var target:FlxSprite;
		private var gun:FlxWeapon;
		
		public function PlayerUnit(_enemyGroup:FlxGroup, _playerBullets:FlxGroup) 
		{
			enemyGroup = _enemyGroup;
			
			loadGraphic(AssetsRegistry.playerPNG);
			
			gun = new FlxWeapon("gun", this);
			
			gun.makeImageBullet(10, AssetsRegistry.playerBulletPNG);
			gun.setBulletBounds(FlxG.worldBounds);
			gun.setFireRate(3000);
			gun.setBulletSpeed(100);
			
			_playerBullets.add(gun.group);
		}
		
		override public function update():void
		{
			super.update();
			
			var closestDistance:int = FlxG.width + FlxG.height;
				
			for each (var enemy:FlxSprite in enemyGroup.members)
			{
				var distanceBetween:int = FlxVelocity.distanceBetween(this, enemy);
				
				if (enemy.alive && enemy.onScreen() && (distanceBetween < closestDistance))
				{
					closestDistance = distanceBetween;
					target = enemy;
				}
			}
			
			if (target && target.alive && target.onScreen())
			{
				this.angle = FlxVelocity.angleBetween(this, target, true);
					
				if (FlxVelocity.distanceBetween(this, target) <= FIRE_RANGE)
				{
					gun.fireAtTarget(target);
				}
			}	
		}
		
		public function findPath(cursorX:Number, cursorY:Number):void
		{
			stopFollowingPath(true);
			
			path = new FlxPath();
			path.add(cursorX, cursorY);
			
			this.followPath(path, 50);
		}
		
	}

}