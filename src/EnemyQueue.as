package  
{
	import org.flixel.plugin.photonstorm.FlxDelay;
	import util.Queue;
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyQueue extends Queue
	{
		private var spawnDelay:FlxDelay;
		
		public function EnemyQueue() 
		{
			spawnDelay = new FlxDelay(3000);
			spawnDelay.callback = activateEnemy;
			spawnDelay.start();
		}
		
		private function activateEnemy():void
		{
			var enemy:Creep = this.read();
			
			if (enemy)
			{
				enemy.startPath();
				
				spawnDelay.reset(6000);
				spawnDelay.start();
			}
			
			else
			{
				spawnDelay.abort();
			}
		}
		
	}

}