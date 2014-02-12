package  
{	
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	 
	public class PlayState extends FlxState
	{
		private const TOTAL_ENEMIES:uint = 6;
		private var gameOver:Boolean = false;
		
		private var playerUnits:FlxGroup;
		private var enemyUnits:FlxGroup;
		private var playerBullets:FlxGroup;
		private var enemyBullets:FlxGroup;
		private var healthBars:FlxGroup;
		private var enemyGibs:FlxGroup;
		private var map:Map
		private var enemyQueue:EnemyQueue;
		private var starField:StarfieldFX;
		private var bg:FlxSprite;
		
		private var base:FlxSprite;
		private var baseExplosion:FlxSprite;
		private var header:FlxText;
		
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
			healthBars = new FlxGroup();
			enemyGibs = new FlxGroup();
			
			enemyQueue = new EnemyQueue();
			
			map = new Map();
	
			createEnemies();
			
			var cursor:Cursor = new Cursor(playerUnits);
			
			createBackgroundObjects();
			
			base = new FlxSprite(0, 276);
			base.loadGraphic(AssetsRegistry.basePNG);
			base.health = 3;
			var baseHealth:FlxBar = new FlxBar(base.x, base.y, FlxBar.FILL_LEFT_TO_RIGHT, 46, 2, base, "health", 0, base.health);
			baseHealth.y -= baseHealth.height * 2;
			
			baseExplosion = new FlxSprite(base.x, base.y);
			baseExplosion.loadGraphic(AssetsRegistry.baseExplosionPNG, true, false, 46, 46);
			baseExplosion.addAnimation("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 60, false);
			baseExplosion.visible = false;
			
			header = new FlxText(0, 0, 300, "");
			header.setFormat(null, 32);
			header.visible = false;
			
			add(bg);
			add(map);
			add(enemyGibs);
			add(base);
			add(baseExplosion);
			add(cursor.highlight);
			add(cursor.moveSprite);
			add(enemyUnits);
			add(healthBars);
			add(baseHealth);
			add(playerUnits);
			add(playerBullets);
			add(enemyBullets);
			add(cursor);
			add(header);
		}
		
		private function createEnemies():void
		{
			for (var i:int = 0; i < TOTAL_ENEMIES; i++)
			{
				var creep:Creep = new Creep(map, healthBars, enemyGibs);
				enemyUnits.add(creep);
				enemyQueue.write(creep);
			}
			
			var boss:Creep = new Creep(map, healthBars, enemyGibs, true);
			enemyUnits.add(boss);
			enemyQueue.write(boss);
		}
		
		override public function update():void
		{
			if (!gameOver) super.update();
			
			if (FlxG.keys.justPressed("R")) FlxG.switchState(new PlayState());
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var playerUnit:PlayerUnit = new PlayerUnit(enemyUnits, playerBullets);
				playerUnit.x = playerUnit.y = 0;
			
				playerUnits.add(playerUnit);
			}
			
			//FlxG.collide(playerUnits, playerUnits);
			FlxG.overlap(playerBullets, enemyUnits, hurtUnit);
			FlxG.overlap(enemyUnits, base, hurtUnit);
		}
		
		private function hurtUnit(hazzard:FlxObject, unit:FlxObject):void
		{
			unit.hurt(1);
			hazzard.kill();
			
			if (hazzard is Creep && unit.health <= 0)
			{
				header.text = ("Game Over");
				header.visible = true;
				gameOver = true;
			}
			
			else if ((unit is Creep && unit.health <= 0) || (hazzard is Creep && hazzard.health <= 0))
			{
				var allDead:Boolean = true;
				
				for each (var enemy:FlxSprite in enemyUnits.members)
				{
					if (enemy.alive) allDead = false;
				}
				
				if (allDead)
				{
					header.text = ("You Win!");
					header.visible = true;
					gameOver = true;
				}
			}
			
			if (!(unit is Creep) && !(unit is PlayerUnit))
			{
				baseExplosion.visible = true;
				baseExplosion.play("explode");
			}
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
			starField.setStarSpeed( FlxMath.randomSign() * 0.05, 0);
		}
		
	}

}