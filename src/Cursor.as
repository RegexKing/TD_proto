package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * ...
	 * @author ...
	 */
	public class Cursor extends FlxObject
	{
		private var selectedUnit:PlayerUnit;
		private var playerUnits:FlxGroup;
		private var cursorCoords:FlxPoint;
		public var highlight:FlxSprite;
		public var moveSprite:FlxSprite;
		
		public function Cursor(_playerUnits:FlxGroup) 
		{
			playerUnits = _playerUnits;
			cursorCoords = new FlxPoint();
			
			highlight = new FlxSprite();
			highlight.makeGraphic(46, 46, 0xff7CFC00);
			highlight.alpha = 0.25;
			highlight.visible = false;
			
			moveSprite = new FlxSprite();
			moveSprite.loadGraphic(AssetsRegistry.movePNG, true, false, 46, 46);
			moveSprite.addAnimation("move", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 60, false);
			moveSprite.visible = false;
		}
		
		override public function update():void
		{
			if (FlxG.mouse.justPressed())
			{
				cursorCoords.x = FlxG.mouse.x;
				cursorCoords.y = FlxG.mouse.y;
				
				var unitFound:Boolean = false;
				
				for each (var playerUnit:PlayerUnit in playerUnits.members)
				{
					if (playerUnit.alive && FlxMath.pointInFlxRect(cursorCoords.x, cursorCoords.y, new FlxRect(playerUnit.x, playerUnit.y, playerUnit.width, playerUnit.height)))
					{
						selectedUnit = playerUnit;
						unitFound = true;
						highlight.visible = true;
						break;
					}
				}
				
				if (selectedUnit && !unitFound)
				{
					selectedUnit.findPath(cursorCoords.x, cursorCoords.y);
					
					moveSprite.visible = true;
					moveSprite.x = cursorCoords.x - (moveSprite.width/2);
					moveSprite.y = cursorCoords.y - (moveSprite.height/2);
					moveSprite.play("move");
				}
				
				
			}
			
			if (selectedUnit)
			{
				highlight.x = selectedUnit.x;
				highlight.y = selectedUnit.y;
			}
		}
		
	}

}