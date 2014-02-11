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
		
		public function Cursor(_playerUnits:FlxGroup) 
		{
			playerUnits = _playerUnits;
			cursorCoords = new FlxPoint();
			
			highlight = new FlxSprite();
			highlight.makeGraphic(46, 46, 0xff7CFC00);
			highlight.alpha = 0.5;
			highlight.visible = false;
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