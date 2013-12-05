package
{
	import flash.display.Sprite;
	import net.hires.debug.Stats;
	import starling.core.Starling
		
	[SWF(framerate = "60", width = "480", height = "800", backgroundColor="0x333333")]
	public class StarlingProject extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function StarlingProject()
		{
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}