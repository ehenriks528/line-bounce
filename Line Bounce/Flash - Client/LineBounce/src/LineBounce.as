package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats; 
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="480", height="800", backgroundColor="0x5882FA")]
	public class LineBounce extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		public function LineBounce()
		{
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			
			myStarling.start();
		}
	}
}