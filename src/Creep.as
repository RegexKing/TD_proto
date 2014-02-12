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
		private var gibs:FlxEmitter;
		private var enemyPath:FlxPath;
		private var speed:int = 0;
		
		
		public function Creep(_map:Map, _healthBars:FlxGroup, _enemyGibs:FlxGroup, _isBoss:Boolean=false) 
		{	
			this.x = 644;
			this.y = 184;
			
			var randSkin:int = Math.ceil(Math.random() * 3);
			
			if (_isBoss)
			{
				loadGraphic(AssetsRegistry.bossPNG);
				this.health = 10;
				speed = 50;
			}
			else if (randSkin == 1)
			{
				loadGraphic(AssetsRegistry.creep1PNG, false, false, 46, 46);
				this.health = 5;
				speed = 50;
			}
			else if (randSkin == 2) 
			{
				loadGraphic(AssetsRegistry.creep2PNG, false, false, 46, 46);
				this.health = 3;
				speed = 60;
				
			}
			else if (randSkin == 3) 
			{
				loadGraphic(AssetsRegistry.creep3PNG, false, false, 46, 46);
				this.health = 7;
				speed = 30;
			}
			
			healthBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 46, 2, this, "health", 0, this.health, false);
			_healthBars.add(healthBar);
			
			gibs = new FlxEmitter();
			gibs.makeParticles(AssetsRegistry.enemyGibsPNG, 50, 16, true);
			gibs.setXSpeed(-500,500);
			gibs.setYSpeed( -500, 500);
			_enemyGibs.add(gibs);
			
			enemyPath = _map.findPath(this.getMidpoint(), _map.endPoint);
		}
	
		public function startPath():void
		{
			this.followPath(enemyPath, speed);
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
			
			gibs.at(this);
			gibs.start(true, 2);
		}
		
	}

}