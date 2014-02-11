package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Creep extends FlxSprite
	{
		public function Creep(_map:Map) 
		{
			this.x = 644;
			this.y = 184;
			
			loadGraphic(AssetsRegistry.creep1PNG, false, false, 46, 46);
			
			var path:FlxPath = _map.findPath(this.getMidpoint(), _map.endPoint);
			
			this.followPath(path, 50);
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.velocity.x > 0) angle = 0;
			else if (this.velocity.x < 0) angle = 180;
			else if (this.velocity.y > 0) angle = 90;
			else if (this.velocity.y < 0) angle = -90;
		}
		
	}

}