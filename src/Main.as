package 
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import flash.events.Event;

	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	[SWF(width="644", height="368", backgroundColor="#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame 
	{
		
		public function Main():void 
		{
			
			super(640, 360, PlayState, 1, 60, 60, true);
			
			forceDebugger = true;
		}
		
		
		override protected function create(FlashEvent:Event):void
		{
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE, onFocusLost);
			stage.removeEventListener(Event.ACTIVATE, onFocus);
		}

	}

}