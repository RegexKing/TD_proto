package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerUnit extends FlxSprite
	{
		private var enemyGroup:FlxGroup;
		private var target:FlxSprite;
		
		public function PlayerUnit(_enemyGroup:FlxGroup) 
		{
			enemyGroup = _enemyGroup;
			
			loadGraphic(AssetsRegistry.playerPNG);
			
			pathSpeed = 50;
		}
		
		override public function update():void
		{
			super.update();
			
			if (!target || !target.alive)
			{
				for each (var enemy:FlxSprite in enemyGroup.members)
				{
					if (enemy.alive)
					{
						target = enemy;
						break;
					}
				}
			}
			
			else
			{
				this.angle = FlxVelocity.angleBetween(this, target, true);
				
				//TODO shoot if in range
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