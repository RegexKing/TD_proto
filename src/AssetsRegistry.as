package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class AssetsRegistry 
	{
		//-- Sprites --//
		
		//enemies
		[Embed(source = "../images/creep-1.png")] public static var creep1PNG:Class;
		[Embed(source = "../images/creep-2.png")] public static var creep2PNG:Class;
		[Embed(source = "../images/creep-3.png")] public static var creep3PNG:Class;
		
		//player units
		[Embed(source = "../images/boss.png")] public static var playerPNG:Class;
		
		//tiles
		[Embed(source = "../images/tileset.png")] public static var tilesetPNG:Class;
		
		//maps
		[Embed(source = "../maps/test.csv", mimeType = "application/octet-stream")] public static var testCSV:Class;
		
		public function AssetsRegistry() {}
		
	}

}