package  
{	
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	 
	public class PlayState extends FlxState
	{
		
		
		private var playerUnits:FlxGroup;
		private var enemyUnits:FlxGroup;
		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var map:Map
		private var creep:Creep;
		private var starField:StarfieldFX;
		private var bg:FlxSprite;
		
		public function PlayState() 
		{ 
		}
		
		override public function create():void
		{	
			if (FlxG.getPlugin(FlxSpecialFX) == null)
            {
                FlxG.addPlugin(new FlxSpecialFX);
            }
			
			playerUnits = new FlxGroup();
			enemyUnits = new FlxGroup();
			playerBullets = new FlxGroup();
			enemyBullets = new FlxGroup();
			
			map = new Map();
	
			creep = new Creep(map);
			enemyUnits.add(creep);
			
			var playerUnit:PlayerUnit = new PlayerUnit(enemyUnits);
			playerUnit.x = playerUnit.y = 0;
			
			var playerUnit2:PlayerUnit = new PlayerUnit(enemyUnits);
			playerUnit2.x = playerUnit2.y = 200;
			
			playerUnits.add(playerUnit);
			playerUnits.add(playerUnit2);
			
			var cursor:Cursor = new Cursor(playerUnits);
			
			createBackgroundObjects();
			
			add(bg);
			add(map);
			add(cursor.highlight);
			add(enemyUnits);
			add(playerUnits);
			add(playerBullets);
			add(enemyBullets);
			add(cursor);
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(creep, map);
		}
		
		override public function destroy():void
         {
            // Important! Clear out the plugin, otherwise resources will get messed right up after a while
            FlxSpecialFX.clear();
			starField.destroy();
			
            super.destroy();
         }
		 
		private function createBackgroundObjects():void
		{
			starField = FlxSpecialFX.starfield();
			
			bg = starField.create(0, 0, FlxG.width, FlxG.height, 250);
			bg.scrollFactor.x = bg.scrollFactor.y = 0;
			starField.setBackgroundColor(0x00);
			starField.setStarSpeed( FlxMath.randomSign() * 0.1, 0);
		}
		
	}

}