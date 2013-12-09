package
{
	import flash.display.Sprite;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	[SWF(frameRate="60", width="480", height="800", backgroundColor="0x5882FA")]
	public class LineBounceMobile extends Sprite
	{
		private static var instance:LineBounceMobile;
		private var stats:Stats;
		private var myStarling:Starling;
		public function LineBounceMobile()
		{
			instance = this;
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			
			myStarling.start();
		}
		
		public static function add(sprite:flash.display.Sprite):void{
			instance.addChild(sprite);
		}
	}
}