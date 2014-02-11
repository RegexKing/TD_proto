package  
{
	import org.flixel.*;
	
	public class HomingUtil
	{
		public static const TIME_DELTA:Number = 0.05;
		public static const RAD:Number = 57.2957795;
		
		static public function easeTowardsTarget(object:FlxSprite, target:FlxSprite, speed:int, turnSpeed:Number = 0.1):Number
		{
			var a:Number = _turnToFace(object.getMidpoint(), target.getMidpoint(), object.angle * Math.PI / 180, turnSpeed);

			var dirX:Number = Math.cos(a);
			var dirY:Number = Math.sin(a);

			object.velocity.x = (dirX) * speed * TIME_DELTA;
			object.velocity.y = (dirY) * speed * TIME_DELTA;
			
			return a * RAD;
		}
		
		private static function _turnToFace(p:FlxPoint, f:FlxPoint, ca:Number, turnSpeed:Number):Number
		{           
			var xp:Number = f.x - p.x;
			var yp:Number = f.y - p.y;

			var desiredAngle:Number = Math.atan2(yp, xp);
			var difference:Number = _wrapAngle(desiredAngle - ca);

			difference = Math.max(-turnSpeed, Math.min(turnSpeed, difference));

			return _wrapAngle(ca + difference); 
		}
		
		private static function _wrapAngle(radians:Number):Number
		{
			var pi2:Number = Math.PI * 2;

			while(radians < -Math.PI) radians += pi2;
			while(radians > Math.PI) radians -= pi2;

			return radians;
		}
		
	}

}