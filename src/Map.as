package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Map extends FlxTilemap
	{
		public var endPoint:FlxPoint;
		
		public function Map() 
		{
			endPoint = new FlxPoint(46 / 2, 276 + (46 / 2));
			
			loadMap(new AssetsRegistry.testCSV, AssetsRegistry.tilesetPNG, 46, 46, 0, 0, 1, 8);
		}
		
	}

}