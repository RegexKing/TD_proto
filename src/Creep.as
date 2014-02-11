package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Creep extends FlxSprite
	{
		private var healthBar:FlxBar;
		private var enemyPath:FlxPath;
		
		public function Creep(_map:Map, _healthBars:FlxGroup) 
		{	
			this.x = 644;
			this.y = 184;
			
			this.health = 3;
			
			healthBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 46, 2, this, "health", 0, this.health, false);
			_healthBars.add(healthBar);
			
			loadGraphic(AssetsRegistry.creep1PNG, false, false, 46, 46);
			
			enemyPath = _map.findPath(this.getMidpoint(), _map.endPoint);
		}
		
		public function startPath():void
		{
			this.followPath(enemyPath, 50);
		}
		
		override public function update():void
		{
			super.update();
			
			healthBar.x = this.x;
			healthBar.y = this.y - healthBar.height * 2;
			
			if (this.velocity.x > 0) angle = 0;
			else if (this.velocity.x < 0) angle = 180;
			else if (this.velocity.y > 0) angle = 90;
			else if (this.velocity.y < 0) angle = -90;
		}
		
		override public function kill():void
		{
			super.kill();
			
			healthBar.kill();
		}
		
	}

}