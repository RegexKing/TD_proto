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
		[Embed(source = "../images/boss.png")] public static var bossPNG:Class;
		
		//gibs
		[Embed(source = "../images/enemyGibs.png")] public static var enemyGibsPNG:Class;
		
		//player units
		[Embed(source = "../images/player.png")] public static var playerPNG:Class;
		
		//bullets
		[Embed(source = "../images/playerBullet.png")] public static var playerBulletPNG:Class;
		
		//structures
		[Embed(source = "../images/base.png")] public static var basePNG:Class;
		
		//cursor
		[Embed(source = "../images/moveAnimation.png")] public static var movePNG:Class;
		
		//explosion
		[Embed(source = "../images/baseExplosion.png")] public static var baseExplosionPNG:Class;
		
		//tiles
		[Embed(source = "../images/tileset.png")] public static var tilesetPNG:Class;
		
		//maps
		[Embed(source = "../maps/test.csv", mimeType = "application/octet-stream")] public static var testCSV:Class;
		
		public function AssetsRegistry() {}
		
	}

}